(define (add-streams s1 s2)
  (stream-map + s1 s2))
(define (mul-streams s1 s2)
  (stream-map * s1 s2))
(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))

; 1 1 2  6  24 120
;   2 3  4   5   6
; 1 2 6 24 120 720
(define factorials (cons-stream 1 (mul-streams (stream-cdr integers) factorials)))
