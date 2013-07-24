(define dx .0001)

(define (smooth f)
  (lambda (x)
    (/ (+ (f (- x dx))
          (f x)
          (f (+ x dx)))
       3)))


(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (iter g x)
    (if (= x n)
      g
      (iter (compose f g) (+ x 1))))

  (iter f 1))

(define (n-fold-smooth f n)
  ((repeated smooth n) f))
