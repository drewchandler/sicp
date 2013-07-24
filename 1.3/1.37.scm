(define (cont-frac n d k)
  (define (cont-frac-recur x)
    (if (> x k)
      (/ (n x) (d x))
      (/ (n x) (+ (d x) (cont-frac-recur (+ x 1))))))

  (cont-frac-recur 1))

;> (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 11)
;Value: .6180555555555556
