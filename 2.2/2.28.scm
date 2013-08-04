(define (fringe t)
  (cond
    ((not (pair? t)) (cons t '()))
    ((null? (cdr t)) (fringe (car t)))
    (else (append (fringe (car t))
                  (fringe (cdr t))))))
