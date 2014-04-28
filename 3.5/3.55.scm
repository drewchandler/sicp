(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (partial-sums s)
  (if (stream-null? s)
    the-empty-stream
    (cons-stream (stream-car s) (add-streams (partial-sums s) (stream-cdr s)))))

(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))
(define ps (partial-sums integers))
