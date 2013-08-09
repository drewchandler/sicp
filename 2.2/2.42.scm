(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define (adjoin-position row col positions)
  (cons (list row col) positions))
(define empty-board '())

(define (safe? column positions)
  (let ((new-row (car (car positions)))
        (new-col (car (cdr (car positions)))))

    (define (safe-relative-to-position? position)
      (cond
        ((= new-row (car position)) false)
        ((= (abs (- new-row (car position)))
            (abs (- new-col (car (cdr position))))) false)
        (else true)))

    (define (safe-iter positions)
      (cond
        ((null? positions) true)
        ((safe-relative-to-position? (car positions)) (safe-iter (cdr positions)))
        (else false)))

    (safe-iter (cdr positions))))
