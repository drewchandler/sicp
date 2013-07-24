(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
       (sum term (next a) next b))))

(define (cube x)
  (* x x x))

(define (integral f a b n)
  (define h (/ (- b a) n))

  (define (inc k) (+ k 1))

  (define (y k)
    (f (+ a (* k h))))

  (define (term k)
    (* (cond ((odd? k) 4)
          ((or (= k 0) (= k n)) 1)
          (else 2)) (y k)))

  (* (/ h 3) (sum term 0.0 inc n)))

;=> (integral cube 0 1 1000)
;Value: .2500000000000003

;=> (integral cube 0 1 100)
;Value: .24999999999999992
