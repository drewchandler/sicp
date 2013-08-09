(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

(define (split first-op second-op)
  (lambda (painter n)
    (if (= n 0)
      painter
      (let ((smaller ((split first-op second-op) painter (- n 1))))
        (first-op painter (second-op smaller smaller))))))

(define (up-split painter n)
  ((split below beside) painter n))

(define (right-split painter n)
  ((split beside below) painter n))

(paint (up-split einstein 2))
(paint (right-split einstein 2))