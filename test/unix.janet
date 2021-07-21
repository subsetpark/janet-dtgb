(import testament :prefix "" :exit true)

(import ./test-helpers :prefix "")

(import ../unix)

(deftest sh-datestr->date
  (assert-is-stdlib-struct! (unix/datestr->date "2020-01-01")))

(run-tests!)
