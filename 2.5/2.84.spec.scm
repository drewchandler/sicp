(load "2.84.scm")

(describe "apply-generic"
  (it "doesn't raise if the args are already the same" (lambda ()
    (let ((result (add (make-integer 10) (make-integer 5))))
      (assert (eq? 'integer (type-tag result)))
      (assert (= 15 (contents result)))
  )))

  (it "can raise an arg up a level to match the other" (lambda ()
    (let ((result (add (make-integer 10) (make-rational 2 3))))
      (assert (eq? 'rational (type-tag result)))
      (assert (= 32 (car (contents result))))
      (assert (= 3 (cdr (contents result))))
  )))

  (it "can raise up multiple levels if needed" (lambda ()
    (let ((result (add (make-integer 10) (make-real 20))))
      (assert (eq? 'real (type-tag result)))
      (assert (= 30 (contents result)))
  )))
)
