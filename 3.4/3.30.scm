(load "3.28.scm")

(define (ripple-carry-adder a b c-in sum c-out)
  (define (make-adder-iter a-in b-in c-in sum-out as bs ss)
    (cond ((null? as)
           (full-adder a-in b-in c-in sum-out c-out))
          (else (let ((carry (make-wire)))
                  (full-adder a-in b-in c-in sum-out carry)
                  (make-adder-iter (car as) (car bs) carry (car ss) (cdr as) (cdr bs) (cdr ss))))))

  (make-adder-iter (car a) (car b) c-in (car sum) (cdr a) (cdr b) (cdr sum))
  'ok)
