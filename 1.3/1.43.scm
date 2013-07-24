(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (iter g x)
    (if (= x n)
      g
      (iter (compose f g) (+ x 1))))

  (iter f 1))
