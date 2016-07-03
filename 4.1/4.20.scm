(define (letrec->let exp)
  (define (unassigned-vars vars)
    (if (null? vars)
      '()
      (cons (list (car vars) ''*unassigned*) (unassigned-vars (cdr vars)))))

  (define (set-to-value vars exps)
    (if (null? vars)
      '()
      (cons (list 'set! (car vars) (car exps))
            (set-to-value (cdr vars) (cdr exps)))))

  (list 'let
        (unassigned-vars (let-variables exp))
        (append (set-to-value (let-variables exp) (let-expressions exp))
                (let-body exp))))
