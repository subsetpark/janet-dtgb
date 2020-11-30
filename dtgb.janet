(import sh)

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

(defn datestr->epoch
  ```
  Given a string representation of a date or datetime, return a number
  representing the UNIX epoch value of that date.
  ```
  [datestr] (-> (sh/$< date -d ,datestr "+%s") (string/trim) (parse)))

(defn datestr->date
  ```
  Given a string representation of a date or datetime, return a struct
  of the kind returned by `os/date`. Pass a truthy value in the second
  argument to adjust for human display (setting values like day and
  month to be 1-indexed).
  ```
  [datestr &opt for-display?]
  (let [parsed (-> datestr
                  (datestr->epoch)
                  (os/date))]
    (if for-display? (human-readable parsed) parsed)))
