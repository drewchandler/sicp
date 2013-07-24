(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (average x y)
  (/ (+ x y) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (iter g x)
    (if (= x n)
      g
      (iter (compose f g) (+ x 1))))

  (iter f 1))

(define (nth-root x n)
  (define (damps x) ???)

  (fixed-point
    (repeated (average-damp (lambda (y) (/ x (expt y (- n 1)))))
              (damps n))
    1.0))
