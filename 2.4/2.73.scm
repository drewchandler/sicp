(define get 2d-get)
(define put 2d-put!)

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) (operands exp) var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (=number? exp num)
  (and (number? exp) (= exp num)))

; a.
; Numbers and symbols aren't be 'tagged' with an operator

; b.
(define (deriv-sum operands var)
  (make-sum (deriv (addend operands) var)
            (deriv (augend operands) var)))

(define (addend operands)
  (car operands))

(define (augend operands)
  (cadr operands))

(define (make-sum addend augend)
  (cond ((=number? addend 0) augend)
        ((=number? augend 0) addend)
        ((and (number? addend) (number? augend)) (+ addend augend))
        (else (list '+ addend augend))))

(put 'deriv '+ deriv-sum)

(define (deriv-product operands var)
  (make-sum
    (make-product (multiplier operands)
                  (deriv (multiplicand operands) var))
    (make-product (deriv (multiplier operands) var)
                  (multiplicand operands))))

(define (multiplier operands)
  (car operands))

(define (multiplicand operands)
  (cadr operands))

(define (make-product multiplier multiplicand)
  (cond ((or (=number? multiplier 0) (=number? multiplicand 0)) 0)
        ((=number? multiplier 1) multiplicand)
        ((=number? multiplicand 1) multiplier)
        ((and (number? multiplier) (number? multiplicand))
         (* multiplier multiplicand))
        (else (list '* multiplier multiplicand))))

(put 'deriv '* deriv-product)

; c.
(define (deriv-exponentiation operands var)
  (make-product
    (make-product (exponent operands)
                  (make-exponentiation (base operands)
                                       (make-sum (exponent operands) -1)))
    (deriv (base operands) var)))

(define (base operands)
  (car operands))

(define (exponent operands)
  (cadr operands))

(define (make-exponentiation base exponent)
  (cond ((=number? exponent 0) 1)
        ((=number? exponent 1) base)
        (else (list '** base exponent))))

(put 'deriv '** deriv-exponentiation)

; d.
; (put <operator> 'deriv <function>)
