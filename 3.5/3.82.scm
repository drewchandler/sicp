(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream
     (/ passed (+ passed failed))
     (monte-carlo
      (stream-cdr experiment-stream) passed failed)))
  (if (stream-car experiment-stream)
      (next (+ passed 1) failed)
      (next passed (+ failed 1))))

(define (random-stream-in-range low high)
  (let ((range (- high low)))
    (cons-stream (+ low (random range)) (random-stream-in-range low high))))

(define (estimate-integral p x1 y1 x2 y2)
  (let ((area (* (abs (- x1 x2))
                      (abs (- y1 y2)))))
    (stream-map
      (lambda (n) (* n area))
      (monte-carlo (stream-map p
                               (random-stream-in-range x1 x2)
                               (random-stream-in-range y1 y2))
                   0 0))))

(define (estimate-pi)
  (define (inside-unit-circle? x y)
    (<= (+ (expt x 2) (expt y 2)) 1))
  (estimate-integral inside-unit-circle? -1.0 -1.0 1.0 1.0))

(display (stream-ref (estimate-pi) 10000))
(newline)
