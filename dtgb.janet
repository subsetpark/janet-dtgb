(import sh)

(defn- adjust-for-display [date]
  (-> (fn [[k v]] (if (and (number? v) (index-of k [:month-day :month :year-day :week-day]))
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
    (if for-display? (adjust-for-display parsed) parsed)))
