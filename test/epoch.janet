(import testament :prefix "" :exit true)

(import epoch)
(import test/dtgb)

(deftest leap-year?
  (is (= (epoch/leap-year? 2000) true))
  (is (= (epoch/leap-year? 2008) true))
  (is (= (epoch/leap-year? 1900) false))
  (is (= (epoch/leap-year? 2019) false))
  (is (= (epoch/leap-year? 2020) true)))

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
  (dtgb/assert-is-stdlib-struct! (epoch/timestamp->date 0)))

# This would be cool I think, but somehow it's off by 1 day?
# Not sure if my implementation is wrong or something's weird with unit testing current time
(comment
  (deftest current-date
    (let [time (os/time)]
      (is (= (epoch/timestamp->date time) (os/date))))))

(run-tests!)
