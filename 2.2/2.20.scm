(define (same-parity a . b)
  (let ((a-parity (remainder a 2)))
    (define (same-parity-iter remaining result)
      (if (null? remaining)
        result
        (same-parity-iter (cdr remaining)
          (if (= a-parity (remainder (car remaining) 2))
            (cons (car remaining) result)
            result))))

    (reverse (same-parity-iter b '()))))
