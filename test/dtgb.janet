(import testament :prefix "" :exit true)
(import test/helpers :prefix "")

(import dtgb)

(deftest sh-datestr->date
  (assert-is-stdlib-struct! (dtgb/datestr->date "2020-01-01")))

(deftest human-readable
  (assert-is-stdlib-struct! (dtgb/human-readable (os/date))))

(run-tests!)
