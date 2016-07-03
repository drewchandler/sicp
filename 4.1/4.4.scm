(define (and? exp) (tagged-list? exp 'and))
(define (and->if exp)
  (let ((exps (cdr exp)))
    (if (null? exps)
      'true
      (expand-and exps))))

(define (expand-and exps)
  (make-if (car exps)
           (if (null? (cdr exps))
             (car exps)
             (expand-and (cdr exps)))))

(define (or? exp) (tagged-list? exp 'or))
(define (or->if exp)
  (let ((exps (cdr exp)))
    (if (null? exps)
      'false
      (expand-or exps))))

(define (expand-or exps)
  (make-if (car exps)
           (car exps)
           (if (null? (cdr exps))
             'false
             (expand-or (cdr exps)))))
