(import testament :prefix "" :exit true)

(import ./test-helpers :prefix "")

(import ../dtgb)

(deftest leap-year?
  (is (= (dtgb/leap-year? 2000) true))
  (is (= (dtgb/leap-year? 2008) true))
  (is (= (dtgb/leap-year? 1900) false))
  (is (= (dtgb/leap-year? 2019) false))
  (is (= (dtgb/leap-year? 2020) true)))

(deftest human-readable
  (assert-is-stdlib-struct! (dtgb/human-readable (os/date))))

(run-tests!)
