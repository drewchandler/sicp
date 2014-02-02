(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (cdr x))
    x
    (last-pair (cdr x))))

(define (count-pairs x)
  (let ((seen-pairs '()))
    (define (do-count y)
      (if (or (not (pair? y)) (memq y seen-pairs))
        0
        (begin
          (set! seen-pairs (cons y seen-pairs))

          (+ (do-count (car y))
             (do-count (cdr y))
             1))))
    (do-count x)))
