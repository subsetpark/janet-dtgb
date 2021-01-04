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

(defn days-in-month
  ```
  Given a year and month (starting at 1), returns the numbers of days in that
  month.
  ```
  [year m]
  (cond
    (and (= m 2) (leap-year? year)) 29
    (= m 2) 28
    (index-of m [4 6 9 11]) 30
    31))

(defn human-readable
  ```
  Given a Janet datetime struct, make those values 1-indexed which are
  1-indexed in human-readable representations.
  ```
  [date]
  (def one-indexed-keys [:month-day :month :year-day :week-day])
  (-> (fn [[k v]] (if (and (number? v) (index-of k one-indexed-keys))
                    [k (inc v)]
                    [k v]))
      (mapcat (pairs date))
      (splice)
      (struct)))
