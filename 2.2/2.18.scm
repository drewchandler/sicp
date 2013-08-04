; Define a procedure reverse that takes a list as argument and returns a list of the same elements in reverse order

;(define (append list1 list2)
;  (if (null? list1)
;      list2
;      (cons (car list1) (append (cdr list1) list2))))
;
;(define (reverse l)
;  (if (null? l)
;    l
;    (append (reverse (cdr l)) (cons (car l) '()) )))
;
(define (reverse l)
  (define (reverse-iter a b)
    (if (null? a)
      b
      (reverse-iter (cdr a)
                    (cons (car a) b))))
  (reverse-iter l '()))
