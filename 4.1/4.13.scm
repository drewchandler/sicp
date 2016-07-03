(define (eval-make-unbound! var env)
  (define (do-unbind env)
    (cond
      ((eq? env the-empty-environment) 'ok)
      (else
        (unbind-from-frame (first-frame env))
        (unbind (enclosing-environment env)))))

  (define (unbind-from-frame frame)
    (define (unbind-thingie previous-var previous-val current-var current-val)
      (cond ((null? current-var) 'ok)
            ((eq? var (car current-var))
             (cond ((null? previous-var)
                    (set-car! frame (cdr current-var))
                    (set-cdr! frame (cdr current-val)))
                   (else
                     (set-cdr! previous-var (cdr current-var))
                     (set-cdr! previous-val (cdr current-val)))))
            (else (unbind-thingie current-var current-val (cdr current-var) (cdr current-val)))))
    (unbind-thingie '() '() (car frame) (cdr frame)))


  (do-unbind env))
