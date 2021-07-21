(import ./epoch)
(import ./units)
(import ./util)

(defn diff
  ```
  Subtracts date2 from date1. Dates must be in Janet date
  format as returned by `os/date`.

  Result is returned in `unit`, defaulting to `:seconds`, and is rounded to the
  nearest integer.

  Options for `unit` are: :seconds :minutes :hours :days :weeks :months :years

  TODO: Currently uses imprecise units for everything above :seconds,
        as defined in `units`. It should walk forward second by second
        to account for month lengths, leap years, etc.
  ```
  [date1 date2 &opt unit]
  (default unit :seconds)
  (let [sec-diff (- (epoch/date->timestamp date2) (epoch/date->timestamp date1))]
    (math/ceil
      (/ sec-diff
         (case unit
           :seconds 1
           :minutes units/minutes
           :hours units/hours
           :days units/days
           :weeks units/weeks
           :months (* 30 units/days) # variable length
           :years (* 365 units/days) # variable length
           (errorf "`%j` is not a valid unit" unit))))))



(defn- sum-up-months [start-date timespan]
  (reduce
    (fn [acc el]
      # TODO: year-ends-passed needs to account for leap year, not just 365 days
      (let [year-ends-passed (math/floor (/ (+ (start-date :year-day) acc) 365))
            year (+ (start-date :year) year-ends-passed)
            month (inc (mod (+ (start-date :month) el) 12))]
        (+ acc (util/days-in-month year month))))
    0
    (range timespan)))

(defn- sum-up-years [start-date timespan]
  (reduce
    (fn [acc el]
      (let [year (+ el (start-date :year))]
        (+ acc (util/days-in-year year))))
    0
    (range timespan)))

(defn add
  ```
  Adds `timespan` to a given date. Optionally takes a `unit`, defaulting to
  `:seconds`. Also supports negative amounts for subtraction
  from a date.

  Options for `unit` are: :seconds :minutes :hours :days :weeks :months :years
  ```
  [date timespan &opt unit]
  (default unit :seconds)
  (let [timestamp (os/mktime date)]
    (os/date
      (+ timestamp
         (case unit
           :seconds timespan
           :minutes (* timespan units/minutes)
           :hours (* timespan units/hours)
           :days (* timespan units/days)
           :weeks (* timespan units/weeks)
           :months (* (sum-up-months date timespan) units/days)
           :years (* (sum-up-years date timespan) units/days)
           (errorf "`%j` is not a valid unit" unit))))))
