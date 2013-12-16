(load "3.1.scm")

(describe "make-accumulator"
  (it "adds the given number to the current count" (lambda ()
    (define A (make-accumulator 5))
    (assert (= 15 (A 10))))))
