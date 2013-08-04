(define (for-each f l)
  (cond
    ((null? l) "Ahpook was here")
    (else
      (f (car l))
      (for-each f (cdr l)))))
