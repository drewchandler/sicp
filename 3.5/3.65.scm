(define (add-streams s1 s2)
  (stream-map + s1 s2))
(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))

(define (partial-sums s)
  (if (stream-null? s)
    the-empty-stream
    (cons-stream (stream-car s) (add-streams (partial-sums s) (stream-cdr s)))))

(define sign-change (cons-stream 1 (stream-map (lambda (x) (* x -1)) sign-change)))
(define ln2 (partial-sums (mul-streams (stream-map (lambda (x) (/ 1.0 x)) integers) sign-change)))
