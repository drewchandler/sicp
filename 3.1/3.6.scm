(define rand
  (let ((x random-init))
    (lambda (op)
      (define (rand-internal)
        (set! x (rand-update x))
        x)

      (cond ((eq? op 'generate) (rand-internal))
            ((eq? op 'reset) (lambda (new-seed) (set! x new-seed)))
            (else (error "WTF?"))))))
