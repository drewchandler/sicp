(define (make-monitored p)
  (let ((count 0))
    (lambda (x)
      (if (eq? x 'how-many-calls)
        count
        (begin
          (set! count (+ count 1))
          (p x))))))
