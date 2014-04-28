(define (smooth s)
  (cons-stream (/ (+ (stream-ref s 0) (stream-ref 1)) 2)
               (smooth (stream-cdr s))))

(define (make-zero-crossings input-stream last-value)
  (cons-stream
   (sign-change-detector (stream-car input-stream) last-value)
   (make-zero-crossings (stream-cdr input-stream)
                        (stream-car input-stream))))

(define zero-crossings (make-zero-crossings (smooth (cons-stream 0 sense-data)) 0))
