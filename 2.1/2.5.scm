(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (divide-evenly x y)
  (define (divide-evenly-iter z n)
    (if (= (remainder z x) 0)
      (divide-evenly-iter (/ z x) (+ n 1))
      n))
  (divide-evenly-iter y 0))

(define (car c)
  (divide-evenly 2 c))

(define (cdr c)
  (divide-evenly 3 c))
