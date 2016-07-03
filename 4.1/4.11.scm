(define (make-frame variables values)
  (map cons variables values))
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons (cons var val) frame)))

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan bindings)
      (cond ((null? bindings) (env-loop (enclosing-environment env)))
            ((eq? var (caar bindings)) (cdar bindings))
            (else (scan (cdr bindings)))))

    (if (eq? env the-empty-environment)
      (error "Unbound variable" var)
      (scan (first-frame env))))

  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan bindings)
      (cond ((null? bindings) (env-loop (enclosing-environment env)))
            ((eq? var (caar bindings)) (set-cdr! (car bindings) val))
            (else (scan (cdr bindings)))))

    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (scan (first-frame env))))

  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan bindings)
      (cond ((null? bindings) (add-binding-to-frame! var val frame))
            ((eq? var (caar bindings)) (set-cdr! (car bindings)))
            (else (scan (cdr bindings)))))

    (scan frame)))
