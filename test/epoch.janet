(import testament :prefix "" :exit true)

(import ./helpers :prefix "")

(import ../epoch)
(import ../dtgb)

(deftest timestamp->date
  (is
    (=
      (epoch/timestamp->date 1606717930)
      {:year 2020
       :month 10
       :month-day 29
       :hours 6
       :minutes 32
       :seconds 10
       :dst false
       :year-day 334
       :week-day 1})))

(deftest zero-date
  (is
    (=
      (epoch/timestamp->date 0)
      {:year 1970
       :month 0
       :month-day 0
       :hours 0
       :minutes 0
       :seconds 0
       :dst false
       :year-day 0
       :week-day 4})))

(deftest stdlib-struct
  (assert-is-stdlib-struct! (epoch/timestamp->date 0)))

(deftest from-datestr
  (is
    (=
      (-> "2020-01-01" dtgb/datestr->epoch epoch/timestamp->date)
      {:year 2020
       :month 0
       :month-day 0
       :year-day 0
       :minutes 0
       :hours 8
       :seconds 0
       :week-day 3
       :dst false})))

(deftest date->epoch
  (is
    (=
      (-> 1606717930 epoch/timestamp->date epoch/date->timestamp)
      1606717930)))

(deftest date->epoch-zero
  (is
    (=
      (epoch/date->timestamp {:year 1970
                              :month 0
                              :month-day 0
                              :hours 0
                              :minutes 0
                              :seconds 0
                              :dst false
                              :year-day 0
                              :week-day 4})
      0)))

(deftest date->epoch-pre-1970
  (is
    (=
      (epoch/date->timestamp {:year 1950
                              :month 0
                              :month-day 0
                              :hours 0
                              :minutes 0
                              :seconds 0
                              :dst false
                              :year-day 0
                              :week-day 4})
      -631152000)))

(run-tests!)
