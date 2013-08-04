; Define a procedure last-pair that returns the list that contains only the last element of a given (nonempty) list
(define (last-pair l)
  (if (null? (cdr l))
    l
    (last-pair (cdr l))))
