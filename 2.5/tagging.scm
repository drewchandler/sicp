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
