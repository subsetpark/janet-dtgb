(import ./epoch)

(defn diff
  ```
  Subtracts date2 from date1. Dates must be in Janet date
  format as returned by `os/date`.

  Result is returned in `unit`, defaulting to `:seconds`, and is rounded to the
  nearest integer.

  Options for `unit` are: :seconds :minutes :hours :days :weeks :months :years
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
