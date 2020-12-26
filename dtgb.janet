(import sh)

(import ./epoch)

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
  
  (note: this shell out to `date` and should be replaced with a native implementation!)
  ```
  [datestr]
  (-> (sh/$< date -d ,datestr "+%s") (string/trim) (parse)))

(defn epoch->datestr
  ```
  Given a UNIX timestamp, return a string representation of the date.

  (note: this shell out to `date` and should be replaced with a native implementation!)
  ```
  [epoch]
  (-> (sh/$< date -u -d ,(string "@" epoch)) (string/trim)))

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
    (math/round
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
