(load "2.84.scm")

(define (drop n)
  (define (do-drop x prev-x)
    (if (and (or (null? prev-x) (not (equal? x prev-x)))
             (equal? (raise (project x)) x))
      (do-drop (project x) x)
      x))

  (do-drop n '()))

(define (project n) (apply-generic 'project n))
(put 'project '(integer) (lambda (n) (make-integer (* n -1))))
(put 'project '(rational) (lambda (n) (make-integer (round (/ (car n) (cdr n))))))
(put 'project '(real) (lambda (n) 
  (let ((rational (rationalize (inexact->exact n) 1/100)))
    (make-rational (numerator rational)
                   (denominator rational)))))
(put 'project '(complex) (lambda (n) (make-real (apply-generic 'real-part n))))

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
                (drop (apply apply-generic op raised-args)))))))))
