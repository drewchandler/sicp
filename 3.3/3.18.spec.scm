(load "3.18.scm")

(describe "cycle?"
  (it "is false for nil" (lambda ()
    (assert (not (cycle? '())))
  ))

  (it "is false for a list without cycles" (lambda ()
    (assert (not (cycle? (list 'a 'b))))
  ))

  (it "is true for a one cons list with a cycle" (lambda ()
    (let ((x (list 'a)))
      (set-cdr! x x)
      (assert (cycle? x)))
  ))

  (it "is true cycle in the car" (lambda ()
    (let ((x (list '(a) 'b)))
      (set-cdr! (car x) x)
      (assert (cycle? x)))
  ))
)
