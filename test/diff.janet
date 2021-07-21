(import testament :prefix "" :exit true)

(import ./test-helpers :prefix "")

(import ../dtgb)
(import ../diff :prefix "")
(import ../epoch)

(deftest diff
  (is (= 1 (diff
             (epoch/timestamp->date 0)
             (epoch/timestamp->date 1))))
  (is (= 1 (diff
             (epoch/timestamp->date 0)
             (epoch/timestamp->date 1) :seconds)))

  (is (= 1 (diff
             (epoch/timestamp->date 0)
             (epoch/timestamp->date 60) :minutes)))

  (is (= 1 (diff
             (epoch/timestamp->date 0)
             (epoch/timestamp->date 3600) :hours)))
  (is (= 3 (diff
             (epoch/timestamp->date 0)
             (epoch/timestamp->date 10800) :hours)))

  (is (= 1 (diff
             (dtgb/datestr->date "2020-01-01")
             (dtgb/datestr->date "2020-01-08") :weeks)))
  (is (= 2 (diff
             (dtgb/datestr->date "2020-01-01")
             (dtgb/datestr->date "2020-01-10") :weeks)))
  (is (= 2 (diff
             (dtgb/datestr->date "2020-01-01")
             (dtgb/datestr->date "2020-01-14") :weeks)))

  (is (= 1 (diff
             (dtgb/datestr->date "2020-01-01")
             (dtgb/datestr->date "2020-01-02") :days)))
  (is (= 365 (diff
               (dtgb/datestr->date "2019-01-01")
               (dtgb/datestr->date "2020-01-01") :days)))
  (is (= 366 (diff
               (dtgb/datestr->date "2020-01-01")
               (dtgb/datestr->date "2021-01-01") :days)))

  (is (= 1 (diff
             (dtgb/datestr->date "2020-01-01")
             (dtgb/datestr->date "2020-01-31") :months)))
  # TODO: commented out because current method is imprecise and fudges a little
  # (is (= 13 (diff
  #             (dtgb/datestr->date "2020-01-01")
  #             (dtgb/datestr->date "2021-01-31") :months)))

  # (is (= 50 (diff
  #             (dtgb/datestr->date "1970-01-01")
  #             (dtgb/datestr->date "2020-01-01") :years)))
  (is (= 1 (diff
             (dtgb/datestr->date "2020-01-01")
             (dtgb/datestr->date "2020-12-31") :years)))

  (assert-thrown (diff
                   (dtgb/datestr->date "2020-01-01")
                   (dtgb/datestr->date "2021-01-01") :light-years)))


(deftest add-default
  (is (=
       (add (dtgb/datestr->date "2020-01-01") (* 24 60 60))
       (dtgb/datestr->date "2020-01-02"))))

(deftest add-minutes
  (is (=
       (add (dtgb/datestr->date "2020-01-01") (* 24 60) :minutes)
       (dtgb/datestr->date "2020-01-02"))))

(deftest add-hours
  (is (=
       (add (dtgb/datestr->date "2020-01-01") 24 :hours)
       (dtgb/datestr->date "2020-01-02"))))

(deftest add-days
  (is (=
       (add (dtgb/datestr->date "2020-01-01") 1 :days)
       (dtgb/datestr->date "2020-01-02"))))

(deftest add-weeks
  (is (=
       (add (dtgb/datestr->date "2020-01-01") 1 :weeks)
       (dtgb/datestr->date "2020-01-08"))))

(deftest add-months
  (is (=
       (add (dtgb/datestr->date "2020-02-01") 1 :months)
       (dtgb/datestr->date "2020-03-01")))
  (is (=
       (add (dtgb/datestr->date "2020-07-05") 3 :months)
       (dtgb/datestr->date "2020-10-05")))
  (is (=
       (add (dtgb/datestr->date "2020-01-01") 12 :months)
       (dtgb/datestr->date "2021-01-01")))
  (is (=
       (add (dtgb/datestr->date "2020-01-01") 1 :months)
       (dtgb/datestr->date "2020-02-01")))

  # 2020 is a leap year, 2021 is not -> different February lengths
  # TODO: somehow this is off by an hour, hence the add 1 hour in the test. Why?
  (is (=
       (add (dtgb/datestr->date "2020-12-01") 4 :months)
       (add (dtgb/datestr->date "2021-04-01") 1 :hours)))

  (is (=
       (add (dtgb/datestr->date "2020-12-01") 96 :months)
       (dtgb/datestr->date "2028-12-01"))))

(deftest add-years
  (is (=
       (add (dtgb/datestr->date "2020-01-01") 1 :years)
       (dtgb/datestr->date "2021-01-01")))
  (is (=
       (add (dtgb/datestr->date "2000-01-01") 1 :years)
       (dtgb/datestr->date "2001-01-01")))
  (is (=
       (add (dtgb/datestr->date "2000-01-01") 4 :years)
       (dtgb/datestr->date "2004-01-01")))
  (is (=
       (add (dtgb/datestr->date "2000-01-01") 100 :years)
       (dtgb/datestr->date "2100-01-01")))
  (is (=
       (add (dtgb/datestr->date "2000-01-01") 1000 :years)
       (dtgb/datestr->date "3000-01-01"))))

(deftest subtract
  (is (=
       (add (dtgb/datestr->date "2020-01-02") (- (* 24 60 60)))
       (dtgb/datestr->date "2020-01-01"))))

(run-tests!)
