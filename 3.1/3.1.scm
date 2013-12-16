(define (make-accumulator count)
  (lambda (n) (begin (set! count (+ count n)) count)))
