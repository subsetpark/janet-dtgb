(import ./epoch)

(defn diff
  ```
  Subtracts date2 from date1. Dates must be in Janet date
  format as returned by `os/date`.

  Result is returned in `unit`, defaulting to `:seconds`, and is rounded to the
  nearest integer.

  Options for `unit` are: :seconds :minutes :hours :days :weeks :months :years

  TODO: Currently uses imprecise units for everything above :seconds,
        as defined in `epoch`. It should walk forward second by second
        to account for month lengths, leap years, etc.
  ```
  [date1 date2 &opt unit]
  (default unit :seconds)
  (let [sec-diff (- (epoch/date->timestamp date2) (epoch/date->timestamp date1))]
    (math/ceil
      (/ sec-diff
         (case unit
           :seconds 1
           :minutes epoch/minutes
           :hours epoch/hours
           :days epoch/days
           :weeks epoch/weeks
           :months epoch/months
           :years epoch/years
           (errorf "`%j` is not a valid unit" unit))))))


(defn add
  ```
  Adds `timespan` to a given date. Optionally takes a `unit`, defaulting to
  `:seconds`. Also supports negative amounts for subtraction
  from a date.

  Options for `unit` are: :seconds :minutes :hours :days :weeks :months :years

  TODO: Currently uses imprecise units for everything above :seconds,
        as defined in `epoch`. It should walk forward second by second
        to account for month lengths, leap years, etc.
  ```
  [date timespan &opt unit]
  (default unit :seconds)
  (let [timestamp (os/mktime date)]
    (os/date
      (+ timestamp
         (* timespan
            (case unit
              :seconds 1
              :minutes epoch/minutes
              :hours epoch/hours
              :days epoch/days
              :weeks epoch/weeks
              :months epoch/months
              :years epoch/years
              (errorf "`%j` is not a valid unit" unit)))))))

