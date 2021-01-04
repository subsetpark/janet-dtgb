(import sh)

(import util)

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

  (note: this shells out to `date` and should be replaced with a native implementation!)
  ```
  [timestamp]
  (-> (sh/$< date -u -d ,(string "@" timestamp)) (string/trim)))

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
    (if for-display? (util/human-readable parsed) parsed)))
