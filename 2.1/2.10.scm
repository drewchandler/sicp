(define (div-interval x y)
  (let ((lower-y (lower-bound y))
        (upper-y (upper-bound y)))
    (if (and (lower-y < 0)
             (upper-y > 0))
      (error "YOU CAN'T SPAN 0, JERK!")
      (mul-interval x
                    (make-interval (/ 1.0 upper-y)
                                   (/ 1.0 lower-y))))))
