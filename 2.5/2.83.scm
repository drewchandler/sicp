(load "get-put.scm")
(load "tagging.scm")
(load "number-packages.scm")

(define (raise number)
  (apply-generic 'raise number))

(put 'raise '(integer) (lambda (n) (make-rational n 1)))
(put 'raise '(rational) (lambda (n) (make-real (exact->inexact (/ (car n) (cdr n))))))
(put 'raise '(real) (lambda (n) (make-complex-from-real-imag n 0)))
