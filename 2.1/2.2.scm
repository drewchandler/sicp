(define (make-segment start end)
  (cons start end))
(define (start-segment segment)
  (car segment))
(define (end-segment segment)
  (cdr segment))

(define (make-point x y)
  (cons x y))
(define (x-point point)
  (car point))
(define (y-point point)
  (cdr point))

(define (avg x y)
  (/ (+ x y) 2))

(define (midpoint-segment segment)
  (make-point
    (avg (x-point (start-segment segment))
         (x-point (end-segment segment)))
    (avg (y-point (start-segment segment))
         (y-point (end-segment segment)))))
