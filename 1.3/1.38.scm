(define (cont-frac n d k)
  (define (cont-frac-recur x)
    (if (> x k)
      (/ (n x) (d x))
      (/ (n x) (+ (d x) (cont-frac-recur (+ x 1))))))

  (cont-frac-recur 1))

(define (e k)
  (+ 2 (cont-frac
    (lambda (x) 1.0)
    (lambda (x)
      (if (= (remainder (+ x 1) 3) 0)
        (* 2 (/ (+ x 1) 3))
        1))
    k)))
