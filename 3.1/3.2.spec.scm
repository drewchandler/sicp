(load "3.2.scm")

(describe "make-monitered"
  (it "returns a lambda that has the original behavior" (lambda ()
    (define s (make-monitored sqrt))
    (assert (= 10 (s 100)))))
  (it "maintains a count of the number of times the lambda has been called" (lambda ()
    (define s (make-monitored sqrt))
    (s 100)
    (s 100)

    (assert (= 2 (s 'how-many-calls)))))
)
