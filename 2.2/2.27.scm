(define (deep-reverse t)
  (cond
    ((not (pair? t)) t)
    ((null? (cdr t)) (deep-reverse (car t)))
    (else (list (deep-reverse (cdr t))
                (deep-reverse (car t))))))
