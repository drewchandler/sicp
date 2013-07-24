; Part a
(define (product term a next b)
  (if (> a b)
    1
    (* (term a) (product term (next a) next b))))

(define (identity x) x)

(define (inc x) (+ x 1))

(define (factorial n)
  (product identity 1 inc n))

(define (pi n)
  (define (num x)
    (if (even? x)
      (+ 2 x)
      (num (- x 1))))

  (define (denom x)
    (if (odd? x)
      (+ 2 x)
      (denom (- x 1))))

  (define (term x)
    (/ (num x) (denom x)))

  (* 4 (product term 1.0 inc n)))

; Part b
(define (product-iter term a next b)
  (define (iter x result)
    (if (> x b)
      result
      (iter (next x) (* (term x) result))))
  (iter a 1))
