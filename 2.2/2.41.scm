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

(define (unique-pairs n)
  (flatmap
    (lambda (i)
      (map (lambda (j) (list i j))
           (enumerate-interval 1 (- i 1))))
    (enumerate-interval 1 n)))

(define (unique-triples n)
  (flatmap
    (lambda (i)
      (map (lambda (pair) (append (list i) pair)) (unique-pairs (- i 1))))
    (enumerate-interval 3 n)))

(define (i-have-no-idea-how-to-name-this n s)
  (filter (lambda (triple) (= s (accumulate + 0 triple))) (unique-triples n)))
