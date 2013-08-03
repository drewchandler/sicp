(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;(add-1 zero)
;(lambda (f) (lambda (x) (f ((zero f) x))))
(define one (lambda (f) (lambda (x) (f x))))

;(add-1 one)
;(add-1 one)
;(lambda (f) (lambda (x) (f (((lambda (z) (lambda (y) (z y))) f) x))))
;(lambda (f) (lambda (x) (f ((lambda (y) (f y)) x))))
(define two (lambda (f) (lambda (x) (f (f x)))))

(define (+ a b)
  (lambda (f) (lambda (x) ((a f) ((b f) x)))))
