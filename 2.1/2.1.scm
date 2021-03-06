(define (make-rat n d)
  (if (< d 0)
    (make-rat (* n -1) (* d -1))
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g)))))
