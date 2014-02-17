(load "ch3.scm")

(define (averager a b c)
  (let ((y (make-connector))
        (z (make-connector)))
    (adder a b y)
    (multiplier c z y)
    (constant 2 z)
    'ok))

(define A (make-connector))
(define B (make-connector))
(define C (make-connector))

(averager A B C)

(probe "A" A)
(probe "B" B)
(probe "C" C)

(set-value! A 50 'user)
(set-value! C 200 'user)
