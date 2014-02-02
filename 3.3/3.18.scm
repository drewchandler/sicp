(define (cycle? x)
  (define (cycle-recur? current seen)
    (cond
      ((not (pair? current)) #f)
      ((memq current seen) #t)
      (else (or (cycle-recur? (car current) (cons current seen))
                (cycle-recur? (cdr current) (cons current seen))))))

  (cycle-recur? x '()))
