(load "2.83.scm")

(describe "raise"
  (it "raises an integer to a rational" (lambda ()
    (let ((rational (raise (make-integer 10))))
      (assert (equal? 'rational (type-tag rational)))
      (assert (= 10 (car (contents rational))))
      (assert (= 1 (cdr (contents rational))))
    )
  ))

  (it "raises a rational to a real" (lambda ()
    (let ((real (raise (make-rational 10 2))))
      (assert (equal? 'real (type-tag real)))
      (assert (= 5 (contents real)))
    )
  ))

  (it "raises a real to a complex" (lambda ()
    (let ((complex (raise (make-real 10))))
      (assert (equal? 'complex (type-tag complex)))
      (assert (= 10 (car (contents (contents complex)))))
      (assert (= 0 (cdr (contents (contents complex)))))
    )
  ))
)
