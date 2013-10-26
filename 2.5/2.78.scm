(define (attach-tag type-tag contents)
  (if (integer? contents)
    contents
    (cons type-tag contents)))

(define (type-tag datum)
  (cond
    ((integer? datum) 'scheme-number)
    ((pair? datum) (car datum))
    (else (error "Bad tagged datum -- TYPE-TAG" datum))))

(define (contents datum)
  (cond
    ((integer? datum) datum)
    ((pair? datum) (cdr datum))
    (else (error "Bad tagged datum -- CONTENTS" datum))))

; This stuff is so I can use this file for the rest of the chapter
(define *op-table* (make-hash-table))

(define (put op type proc)
  (hash-table/put! *op-table* (list op type) proc))

(define (get op type)
  (hash-table/get *op-table* (list op type) '()))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
            "No method for these types -- APPLY-GENERIC"
            (list op type-tags))))))
