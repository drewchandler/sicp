(define (add-streams s1 s2)
  (stream-map + s1 s2))
(define (mul-streams s1 s2)
  (stream-map * s1 s2))
(define (div-streams s1 s2)
  (stream-map / s1 s2))
(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))

(define (integrate-series s)
  (if (stream-null? s)
    the-empty-stream
    (mul-streams (div-streams ones integers) s)))

(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

(define cosine-series
  (cons-stream 1 (stream-map (lambda (x) (* -1 x)) (integrate-series sine-series))))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))
