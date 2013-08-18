(load "2.56.scm")

(define (multiplicand p)
  (if (null? (cdddr p))
      (caddr p)
      (cons '* (cddr p))))

(define (augend s)
  (if (null? (cdddr s))
    (caddr s)
    (cons '+ (cddr s))))
