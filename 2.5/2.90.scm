(load "get-put.scm")
(load "tagging.scm")
(load "number-packages.scm")

(define (adjoin-term term term-list)
  ((get 'adjoin-term (type-tag term-list)) term (contents term-list)))
(define (empty-termlist? term-list) (apply-generic 'empty-termlist? term-list))
(define (first-term term-list) (apply-generic 'first-term term-list))
(define (rest-terms term-list) (apply-generic 'rest-terms term-list))

(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))

(define (install-dense-term-list)
  (define (tag t) (attach-tag 'dense-term-list t))

  (define (dense-adjoin-term term term-list)
    (if (= (length term-list) (order term))
      (cons (coeff term) term-list)
      (dense-adjoin-term term (cons 0 term-list))))

  (put 'the-empty-termlist 'dense-term-list (lambda () (tag '())))

  (put 'adjoin-term 'dense-term-list (lambda (term term-list)
    (tag (dense-adjoin-term term term-list))))

  (put 'empty-termlist? '(dense-term-list) (lambda (term-list) (null? term-list)))

  (put 'first-term '(dense-term-list) (lambda (term-list)
    (make-term (- (length term-list) 1) (car term-list))))

  (put 'rest-terms '(dense-term-list) (lambda (term-list)
    (tag (cdr term-list))))

  'done)
(install-dense-term-list)

(define (install-sparse-term-list)
  (define (tag t) (attach-tag 'sparse-term-list t))

  (define (sparse-adjoin-term term term-list)
    (if (=zero? (coeff term))
        term-list
        (cons term term-list)))

  (put 'the-empty-termlist 'sparse-term-list (lambda () (tag '())))

  (put 'adjoin-term 'sparse-term-list (lambda (term term-list)
    (tag (sparse-adjoin-term term term-list))))

  (put 'empty-termlist? '(sparse-term-list) (lambda (term-list) (null? term-list)))

  (put 'first-term '(sparse-term-list) (lambda (term-list)
    (car term-list)))

  (put 'rest-terms '(sparse-term-list) (lambda (term-list)
    (tag (cdr term-list))))

  'done)
(install-sparse-term-list)

(define (install-polynomial-package)
  (define (make-poly variable term-list)
    (cons variable term-list))
  (define (variable p) (car p))
  (define (term-list p) (cdr p))
  (define (variable? x) (symbol? x))
  (define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))

  (define (add-terms L1 L2)
    (cond ((empty-termlist? L1) L2)
          ((empty-termlist? L2) L1)
          (else
           (let ((t1 (first-term L1)) (t2 (first-term L2)))
             (cond ((> (order t1) (order t2))
                    (adjoin-term
                     t1 (add-terms (rest-terms L1) L2)))
                   ((< (order t1) (order t2))
                    (adjoin-term
                     t2 (add-terms L1 (rest-terms L2))))
                   (else
                    (adjoin-term
                     (make-term (order t1)
                                (add (coeff t1) (coeff t2)))
                     (add-terms (rest-terms L1)
                                (rest-terms L2)))))))))

  (define (mul-terms L1 L2)
    (if (empty-termlist? L1)
        ((get 'the-empty-termlist (type-tag L1)))
        (add-terms (mul-term-by-all-terms (first-term L1) L2)
                   (mul-terms (rest-terms L1) L2))))
  (define (mul-term-by-all-terms t1 L)
    (if (empty-termlist? L)
        ((get 'the-empty-termlist (type-tag L1)))
        (let ((t2 (first-term L)))
          (adjoin-term
           (make-term (+ (order t1) (order t2))
                      (mul (coeff t1) (coeff t2)))
           (mul-term-by-all-terms t1 (rest-terms L))))))

  (define (negate-poly p)
    (make-poly (variable p) (negate-terms (term-list p))))
  (define (negate-terms t)
    (define (negate-iter remaining-terms negated-terms)
      (if (empty-termlist? remaining-terms)
        negated-terms
        (adjoin-term (make-term (order (first-term remaining-terms))
                                (negate (coeff (first-term remaining-terms))))
                     (rest-terms remaining-terms))))
    (negate-iter t ((get 'the-empty-termlist (type-tag t)))))

  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (add-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- ADD-POLY"
               (list p1 p2))))
  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (mul-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- MUL-POLY"
               (list p1 p2))))

  (define (tag p) (attach-tag 'polynomial p))
  (put 'add '(polynomial polynomial)
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'sub '(polynomial polynomial)
       (lambda (p1 p2) (tag (add-poly p1 (negate-poly p2)))))
  (put 'mul '(polynomial polynomial)
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put '=zero? '(polynomial) (lambda (x)
    (define (all-terms-zero? terms)
      (if (empty-termlist? terms)
        #t
        (and (=zero? (coeff (first-term terms)))
             (all-terms-zero? (rest-terms terms)))))
    (all-terms-zero? (term-list x))))
  (put 'negate '(polynomial) (lambda (x)
    (tag (negate-poly x))))

  (put 'make 'polynomial
       (lambda (var terms) (tag (make-poly var terms))))
  'done)
(install-polynomial-package)

(define (make-poly var terms) ((get 'make 'polynomial) var terms))
