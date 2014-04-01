(define (make-semaphore size)
  (let ((mutex (make-mutex))
        (count 0))

    (define (incr)
      (mutex 'acquire)
      (cond
        ((< count (- size 1))
          (set! count (+ count 1))
          (mutex 'release))
        (else
          (mutex 'release)
          (the-semaphore 'acquire))))

    (define (decr)
      (mutex 'acquire)
      (set! count (- count 1))
      (mutex 'release))

    (define (the-semaphore m)
      (cond ((eq? m 'acquire) (incr))
             (eq? m 'release) (decr)))

    the-semaphore))
