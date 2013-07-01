(define (f-recur n)
  (if (< n 3)
    n
    (+ (f-recur (- n 1))
       (* 2 (f-recur (- n 2)))
       (* 3 (f-recur (- n 3))))))

(define (f-iter n)
  (define (iter count a b c)
    (if (= count 0)
      a
      (iter (- count 1) (+ a (* 2 b) (* 3 c)) a b)))

  (if (< n 3)
    n
    (iter (- n 2) 2 1 0)))
