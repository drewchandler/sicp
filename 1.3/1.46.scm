(define (iterative-improve good-enough improve)
  (define (try-guess guess)
    (if (good-enough guess)
      guess
      (try-guess (improve guess))))

  (lambda (guess) (try-guess guess)))

(define (average a b)
  (/ (+ a b) 2))

(define (sqrt x)
  ((iterative-improve
    (lambda (guess) (< (abs (- (square guess) x)) 0.001))
    (lambda (guess) (average guess (/ x guess))))
   1.0))

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  ((iterative-improve
     (lambda (guess) (< (abs (- guess (f guess))) tolerance))
     (lambda (guess) (f guess)))
   first-guess))
