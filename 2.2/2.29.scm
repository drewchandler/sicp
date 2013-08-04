(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch m)
  (car m))

(define (right-branch m)
  (car (cdr m)))

(define (branch-length b)
  (car b))

(define (branch-structure b)
  (car (cdr b)))

(define (total-weight m)
  (if (not (pair? m))
    m
    (+ (total-weight (branch-structure (left-branch m)))
       (total-weight (branch-structure (right-branch m))))))

(define (branch-torque b)
  (* (branch-length b)
     (total-weight (branch-structure b))))

(define (balanced? m)
  (if (not (pair? m))
    true
    (and
      (= (branch-torque (left-branch m))
         (branch-torque (right-branch m)))
      (balanced? (branch-structure (left-branch m)))
      (balanced? (branch-structure (left-branch m))))))

(define small (make-mobile (make-branch 1 5) (make-branch 1 5)))

(define medium (make-mobile (make-branch 1 small) (make-branch 1 small)))

(define large (make-mobile (make-branch 1 medium) (make-branch 1 medium)))

;(define (right-branch m)
;  (cdr m))
;
;(define (branch-structure b)
;  (cdr b))
