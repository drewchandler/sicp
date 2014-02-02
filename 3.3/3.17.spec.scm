(load "3.17.scm")

(describe "count-pairs"
  (it "handles nil" (lambda ()
    (assert (= 0 (count-pairs '())))
  ))

  (it "handles one cons" (lambda ()
    (assert (= 1 (count-pairs (list 'a))))
  ))

  (it "handles longer lists" (lambda ()
    (assert (= 3 (count-pairs (list 'a 'b 'c))))
  ))

  (it "handles reused items" (lambda ()
    (let ((x (list 'a)))
      (assert (= 2 (count-pairs (cons x x)))))
  ))

  (it "handles cycles" (lambda ()
    (let ((x (list 'a)))
      (set-cdr! x x)
      (assert (= 1 (count-pairs x))))
  ))
)
