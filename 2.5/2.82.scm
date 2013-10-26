(load "get-put.scm")
(load "tagging.scm")

(define (try-coercing-args types-to-try args)
  (if (null? types-to-try)
    '()
    (let ((coerced-args (coerce-args args (car types-to-try))))
      (if (not (null? coerced-args))
        coerced-args
        (try-coercing-args (cdr types-to-try) args)))))

(define (coerce-args args type)
  (define (coerce-first remaining-args coerced-args)
    (if (null? remaining-args)
      coerced-args
      (let ((arg (car remaining-args))
            (arg-type (type-tag (car remaining-args))))
        (if (equal? arg-type type)
          (coerce-first (cdr remaining-args) (append coerced-args (list arg)))
          (let ((coercion (get-coercion arg-type type)))
            (if coercion
              (coerce-first (cdr remaining-args) (append coerced-args (list (coercion arg))))
              '()))))))

  (coerce-first args '()))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (let ()
            (apply proc (map contents args)))
          (let ((coerced-args (try-coercing-args (map type-tag args) args)))
            (if (not (null? coerced-args))
              (apply apply-generic op coerced-args)
              (error "No method for these types" (list op type-tags))))))))
