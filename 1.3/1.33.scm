(define (filtered-accumulate filter combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner
      (if (filter a) (term a) null-value)
      (filtered-accumulate filter combiner null-value term (next a) next b))))

; Part a
(define (sum-of-squares-for-primes a b)
  (define (square x) (* x x))
  (define (inc x) (+ x 1))
  (define (prime? x) (even? x))

  (filtered-accumulate prime? + 0 square a inc b))

; Part b
(define (product-of-numbers-relatively-prime-to n)
  (define (identity x) x)
  (define (inc x) (+ x 1))
  (define (relatively-prime? x) (= 1 (gcd x n)))

  (filtered-accumulate relatively-prime? * 1 identity 0 inc (- n 1)))
