(define random-init 1)
(define (rand-update x) (* x 37))

(define (random-stream request-stream)
  (define (generate-random-stream initial-value)
    (cons-stream initial-value (generate-random-stream (rand-update initial-value))))

  (define (rands-for-requests requests rands)
    (if (stream-null? requests)
      the-empty-stream
      (let ((request (stream-car requests)))
        (if (pair? request)
          (rands-for-requests (stream-cdr requests) (generate-random-stream (rand-update (cdr request))))
          (cons-stream (stream-car rands) (rands-for-requests (stream-cdr requests) (stream-cdr rands)))))))

  (rands-for-requests request-stream (generate-random-stream random-init)))

(define rands (random-stream (stream 'generate 'generate (cons 'reset 5) 'generate 'generate (cons 'reset 10) 'generate)))
