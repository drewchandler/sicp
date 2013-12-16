(load "3.5.scm")

(describe "estimate-integral"
  (it "can estimate area" (lambda ()
    (let ((predicate (lambda (x y) (<= (+ (expt (- x 5) 2) (expt (- y 7) 2)) 9))))
      (let ((area-estimate (estimate-integral predicate 2.0 4.0 8.0 10.0 1000)))
        (assert (and (> area-estimate 27)
                     (< area-estimate 29)))))))
)

(describe "estimate-pi"
  (it "estimates pi" (lambda ()
    (let ((pi-estimate (estimate-pi 1000)))
      (assert (and (> pi-estimate 2)
                   (< pi-estimate 4))))))
)
