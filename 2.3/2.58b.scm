(define (deriv exp var)
  (display exp)
  (newline)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((exponentiation? exp)
          (make-product (make-product (exponent exp)
                                      (make-exponentiation (base exp)
                                                           (make-sum (exponent exp) -1)))
                        (deriv (base exp) var)))
        (else
         (error "unknown expression type -- DERIV" exp))))


(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (split-sum x)
  (split-exp x '+))

(define (sum? x)
  (not (null? (split-sum x))))
(define (addend s)
  (let ((a (car (split-sum s))))
    (if (null? (cdr a))
      (car a)
      a)))
(define (augend s)
  (let ((a (cadr (split-sum s))))
    (if (null? (cdr a))
      (car a)
      a)))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))

(define (split-product x)
  (split-exp x '*))

(define (product? x)
  (not (null? (split-product x))))
(define (multiplier p)
  (let ((m (car (split-product p))))
    (if (null? (cdr m))
      (car m)
      m)))
(define (multiplicand p)
  (let ((m (cadr (split-product p))))
    (if (null? (cdr m))
      (car m)
      m)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-exponentiation base exponent)
  (cond ((=number? exponent 0) 1)
        ((=number? exponent 1) base)
        (else (list base '** exponent))))

(define (split-exponentiation x)
  (split-exp x '**))

(define (exponentiation? x)
  (not (null? (split-exponentiation x))))

(define (base e)
  (let ((m (car (split-exponentiation e))))
    (if (null? (cdr m))
      (car m)
      m)))

(define (exponent e)
  (let ((m (cadr (split-exponentiation e))))
    (if (null? (cdr m))
      (car m)
      m)))

(define (split-exp exp op)
  (define (split-exp-iter e lhs)
    (cond
      ((null? e) '())
      ((eq? op (car e)) (list lhs (cdr e)))
      (else (split-exp-iter (cdr e) (append lhs (list (car e)))))))

  (split-exp-iter exp '()))
