(define (pascal-element row col)
  (cond ((= col 1) 1)
        ((= col row) 1)
        (else (+ (pascal-element (- row 1) (- col 1))
                 (pascal-element (- row 1) col)))))