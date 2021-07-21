(import testament :prefix "" :exit true)

(import ./test-helpers :prefix "")

(import ../dtgb)

(deftest leap-year?
  (is (= (dtgb/leap-year? 2000) true))
  (is (= (dtgb/leap-year? 2008) true))
  (is (= (dtgb/leap-year? 1900) false))
  (is (= (dtgb/leap-year? 2019) false))
  (is (= (dtgb/leap-year? 2020) true)))

(deftest days-in-year
  (is (= (dtgb/days-in-year 2000) 366))
  (is (= (dtgb/days-in-year 2001) 365)))

(deftest days-in-month
  (is (= (dtgb/days-in-month 2000 2) 29))
  (is (= (dtgb/days-in-month 2001 2) 28))
  (is (= (dtgb/days-in-month 2000 6) 30))
  (is (= (dtgb/days-in-month 2000 7) 31)))

(deftest human-readable
  (assert-is-stdlib-struct! (dtgb/human-readable (os/date))))

(run-tests! :exit-on-fail false)
