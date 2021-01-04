### epoch.janet
###
### datetime logic for handling UNIX epoch time, that is, datetimes
### expressed as seconds from the UNIX epoch.
###
### in this module, `date` refers to a struct of the type returned by
### `os/date`, and `timestamp` refers to an epoch timestamp.
(import ./util)

# Algorithm copied from `gmtime`:
# https://stackoverflow.com/questions/1692184/converting-epoch-time-to-real-date-time

# TODO: negative timestamps for dates before 1970

(def minutes 60)
(def hours (* 60 60))
(def days (* 24 60 60))
(def weeks (* 7 24 60 60))
(def months (* 30 days))
(def years (* 365 days))

(defn- div [x y]
  (math/floor (/ x y)))

(defn- dayno->year [dayno year]
  (let [size (util/days-in-year year)]
    (if (>= dayno size)
      (dayno->year (- dayno size) (inc year))
      {:year year :dayno_left dayno})))

(defn- dayno->month [year dayno month]
  (let [size (util/days-in-month year month)]
    (if (>= dayno size)
      (dayno->month year (- dayno size) (inc month))
      {:month month :dayno_left dayno})))

(defn timestamp->date
  ```
  Given an epoch timestamp in seconds, returns a date structure
  corresponding to that timestamp, in the same format as Janet's `os/date`.
  ```
  [timestamp]
  (let [dayclock (% timestamp days)
        dayno (div timestamp days)
        {:year year :dayno_left month_dayno_left} (dayno->year dayno 1970)
        {:month month :dayno_left day_dayno_left} (dayno->month year month_dayno_left 0)]
    {:year year
     :month month
     :month-day day_dayno_left
     :week-day (% (+ dayno 4) 7) # day 0 was a Thursday
     :year-day month_dayno_left
     :hours (div dayclock 3600)
     :minutes (div (% dayclock 3600) 60)
     :seconds (% dayclock 60)
     :dst false}))

(defn- year->days [year]
  (reduce + 0 (map util/days-in-year (range 1970 year))))

(defn- month->days [year month]
  (reduce + 0 (map |(util/days-in-month year (inc $)) (range month))))

(defn date->timestamp
  ```
  Given a Janet date, returns the corresponding epoch timestamp in seconds.
  ```
  [{:year year :month month :month-day day
    :hours hours :minutes minutes :seconds seconds}]
  (+
    (* days
       (+
         (year->days year)
         (month->days year month)
         day))
    (* 60 60 hours)
    (* 60 minutes)
    seconds))
