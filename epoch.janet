# Algorithm copied from `gmtime`: https://stackoverflow.com/questions/1692184/converting-epoch-time-to-real-date-time

(def- days (* 24 60 60))
(def- months (* 30 days))
(def- years (* 365 days))

(defn- div [x y]
  (math/floor (/ x y)))

(defn leap-year?
  ```
  Given a year, returns true if the year is a leap year, false otherwise.
  ```
  [year]
  (let [dy |(= 0 (% year $))]
    (cond
      (dy 400) true
      (dy 100) false
      (dy 4) true
      false)))

(defn days-in-year
  ```
  Given a year, returns 366 for leap years and 365 otherwise.
  ```
  [year]
  (if (leap-year? year) 366 365))

(defn- dayno->year [dayno year]
  (let [size (days-in-year year)]
    (if (>= dayno size)
      (dayno->year (- dayno size) (inc year))
      {:year year :dayno_left dayno})))

(defn days-in-month
  ```
  Given a year and month (starting at 1), returns the numbers of days in that
  month.
  ```
  [year m]
  (cond
    (and (= m 2) (leap-year? year)) 29
    (= m 2)  28
    (index-of m [4 6 9 11]) 30
    31))

(defn- dayno->month [year dayno month]
  (let [size (days-in-month year month)]
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
  (reduce + 0 (map days-in-year (range 1970 year))))

(defn- month->days [year month]
  (reduce + 0 (map |(days-in-month year (inc $)) (range month))))

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
