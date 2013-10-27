(load "2.85.scm")

(describe "drop"
  (it "does nothing to an integer" (lambda ()
    (let ((result (drop (make-integer 5))))
      (assert (equal? result (make-integer 5)))
    )
  ))

  (it "lowers a rational with a 1 denominator" (lambda ()
    (let ((result (drop (make-rational 10 1))))
      (assert (equal? result (make-integer 10)))
    )
  ))

  (it "does nothing to a rational with a non-one denominator" (lambda ()
    (let ((result (drop (make-rational 10 3))))
      (assert (equal? result (make-rational 10 3)))
    )
  ))

  (it "lowers a real to an integer" (lambda ()
    (let ((result (drop (make-real 10))))
      (assert (equal? result (make-integer 10)))
    )
  ))

  (it "lowers a real to a rational" (lambda ()
    (let ((result (drop (make-real .5))))
      (assert (equal? result (make-rational 50 100)))
    )
  ))

  (it "lowers a complex without an imaginary part all the way to an integer" (lambda ()
    (let ((result (drop (make-complex-from-real-imag 10. 0))))
      (assert (equal? result (make-integer 10)))
    )
  ))
)

(describe "apply-generic"
  (it "raises and lowers" (lambda ()
    (let ((result (mul (make-integer 4) (make-rational 3 4))))
      (assert (eq? 'integer (type-tag result)))
      (assert (= 3 (contents result)))
    )
  ))
)
