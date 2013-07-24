(define (cont-frac n d k)
  (define (cont-frac-recur x)
    (if (> x k)
      (/ (n x) (d x))
      (/ (n x) (+ (d x) (cont-frac-recur (+ x 1))))))

  (cont-frac-recur 1))

(define (tan-cf x k)
  (cont-frac
    (lambda (n) (if (= n 1) x (* -1 (* x x))))
    (lambda (n) (+ (* 2 (- n 1)) 1))
    k))
