(define random-init 1)
(define (rand-update x) (* x 37))
(load "3.6.scm")

(describe "rand"
  (it "produces the next random number in the sequence" (lambda ()
    (assert (= 37 (rand 'generate)))
    (assert (= 1369 (rand 'generate)))))

  (it "can reset the seed" (lambda ()
    ((rand 'reset) 10)
    (assert (= 370 (rand 'generate)))))
)
