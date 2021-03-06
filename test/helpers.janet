(import testament :prefix "" :exit true)

(defn assert-is-stdlib-struct!
  ```
  Assert that the given object has the same fields, with the same
  types, as the date objects produced by the Janet standard library.
  ```
  [obj]
  (let [date (os/date)]
    (loop [[k v] :pairs date]
      (is (not (nil? (in obj k))))
      (is (= (type (obj k)) (type v))))))
