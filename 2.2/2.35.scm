(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (fringe t)
  (cond
    ((not (pair? t)) (cons t '()))
    ((null? (cdr t)) (fringe (car t)))
    (else (append (fringe (car t))
                  (fringe (cdr t))))))

(define (count-leaves t)
  (accumulate + 0 (map (lambda (x) 1) (fringe t))))
