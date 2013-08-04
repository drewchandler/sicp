(define (tree-map f tree)
  (cond
    ((null? tree) '())
    ((not (pair? tree)) (f tree))
    (else (map (lambda (t) (tree-map f t)) tree))))

(define (square-tree tree) (tree-map square tree))
