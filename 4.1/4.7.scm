(define (let*? exp) (tagged-list? exp 'let*))
(define (let*-assignments exp) (cadr exp))
(define (let*-body exp) (caddr exp))

(define (let*->nested-lets exp)
  (define (convert assignments body)
    (if (null? assignments)
      body
      (list 'let
            (list (car assignments))
            (convert (cdr assignments) body))))

  (convert (let*-assignments exp) (let*-body exp)))
