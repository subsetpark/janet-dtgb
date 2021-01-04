(import testament :prefix "" :exit true)
(import test/helpers :prefix "")

(import ../dtgb)
(import ../epoch)

(deftest leap-year?
  (is (= (dtgb/leap-year? 2000) true))
  (is (= (dtgb/leap-year? 2008) true))
  (is (= (dtgb/leap-year? 1900) false))
  (is (= (dtgb/leap-year? 2019) false))
  (is (= (dtgb/leap-year? 2020) true)))

(deftest human-readable
  (assert-is-stdlib-struct! (dtgb/human-readable (os/date))))

(deftest diff
  (is (= 1 (dtgb/diff
             (epoch/timestamp->date 0)
             (epoch/timestamp->date 1))))
  (is (= 1 (dtgb/diff
             (epoch/timestamp->date 0)
             (epoch/timestamp->date 1) :seconds)))

  (is (= 1 (dtgb/diff
             (epoch/timestamp->date 0)
             (epoch/timestamp->date 60) :minutes)))

  (is (= 1 (dtgb/diff
             (epoch/timestamp->date 0)
             (epoch/timestamp->date 3600) :hours)))
  (is (= 3 (dtgb/diff
             (epoch/timestamp->date 0)
             (epoch/timestamp->date 10800) :hours)))

  (is (= 1 (dtgb/diff
             (dtgb/datestr->date "2020-01-01")
             (dtgb/datestr->date "2020-01-08") :weeks)))
  (is (= 1 (dtgb/diff
             (dtgb/datestr->date "2020-01-01")
             (dtgb/datestr->date "2020-01-10") :weeks)))
  (is (= 2 (dtgb/diff
             (dtgb/datestr->date "2020-01-01")
             (dtgb/datestr->date "2020-01-14") :weeks)))

  (is (= 1 (dtgb/diff
             (dtgb/datestr->date "2020-01-01")
             (dtgb/datestr->date "2020-01-02") :days)))
  (is (= 365 (dtgb/diff
               (dtgb/datestr->date "2019-01-01")
               (dtgb/datestr->date "2020-01-01") :days)))
  (is (= 366 (dtgb/diff
               (dtgb/datestr->date "2020-01-01")
               (dtgb/datestr->date "2021-01-01") :days)))

  (is (= 1 (dtgb/diff
             (dtgb/datestr->date "2020-01-01")
             (dtgb/datestr->date "2020-02-01") :months)))
  (is (= 13 (dtgb/diff
              (dtgb/datestr->date "2020-01-01")
              (dtgb/datestr->date "2021-02-01") :months)))

  (is (= 50 (dtgb/diff
              (dtgb/datestr->date "1970-01-01")
              (dtgb/datestr->date "2020-01-01") :years)))
  (is (= 1 (dtgb/diff
             (dtgb/datestr->date "2020-01-01")
             (dtgb/datestr->date "2021-01-01") :years)))

  (assert-thrown (dtgb/diff
                   (dtgb/datestr->date "2020-01-01")
                   (dtgb/datestr->date "2021-01-01") :light-years)))

(run-tests!)
