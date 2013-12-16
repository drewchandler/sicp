(define (make-f)
  (let ((x 0))
    (lambda (y)
      (let ((t x))
        (set! x y)
        t))))

(describe "f"
  (it "should be 0 with ltr evaluation" (lambda ()
    (let ((f (make-f)))
      (assert (= 0 (f 0)))
      (assert (= 0 (f 1))))))

  (it "should be 0 with rtl evaluation" (lambda ()
    (let ((f (make-f)))
      (assert (= 0 (f 1)))
      (assert (= 1 (f 0))))))
)
