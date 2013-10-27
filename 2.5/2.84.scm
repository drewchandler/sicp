(load "2.83.scm")

(define number-types '(integer rational real complex))

(define (apply-generic op . args)
  (define (highest-type type-tags)
    (define (highest-type-iter remaining-types current-highest)
      (if (null? remaining-types)
        (if (null? current-highest)
          current-highest
          (car current-highest))
        (let ((current (memq (car remaining-types) number-types)))
          (if (or (null? current-highest)
                  (< (length current) (length current-highest)))
             (highest-type-iter (cdr remaining-types) current)
             (highest-type-iter (cdr remaining-types) current-highest)))))

    (highest-type-iter type-tags '()))


  (define (raise-all type args)
    (define (raise-all-iter current-arg remaining-args risen-args)
      (cond ((equal? (type-tag current-arg) type)
             (if (null? remaining-args)
               (append risen-args (list current-arg))
               (raise-all-iter (car remaining-args) 
                               (cdr remaining-args) 
                               (append risen-args (list current-arg)))))
            (else
              (raise-all-iter (raise current-arg) remaining-args risen-args))))

    (raise-all-iter (car args) (cdr args) '()))

  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (let ((raise-to (highest-type type-tags)))
            (let ((raised-args (raise-all raise-to args)))
              (if (equal? (map type-tag raised-args) type-tags)
                (error "No method for these types" (list op type-tags))
                (apply apply-generic op raised-args))))))))
