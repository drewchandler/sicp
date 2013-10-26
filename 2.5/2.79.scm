(load "2.78.scm")
(load "number-packages.scm")

(define (equ? x y) (apply-generic 'equ? x y))

(put 'equ? '(scheme-number scheme-number) (lambda (x y) (= x y)))
(put 'equ? '(rational rational)
     (lambda (x y) (and (= (numer x) (numer y))
                        (= (denom x) (denom y)))))
(put 'equ? '(complex complex)
     (lambda (x y) (and (= (real-part x) (real-part y))
                        (= (imag-part x) (imag-part y)))))
