(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q)))

; (cdr (cons 5 10))
; (cdr (lambda (m) (m 5 10)))
; ((lambda (m) (m 5 10)) (lambda (p q) q))
; ((lambda (p q) q) 5 10)
; 10
