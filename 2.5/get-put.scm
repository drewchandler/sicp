(define *op-table* (make-hash-table))

(define (put op type proc)
  (hash-table/put! *op-table* (list op type) proc))

(define (get op type)
  (hash-table/get *op-table* (list op type) #f))

(define *coercion-table* (make-hash-table))

(define (put-coercion from to coercion)
  (hash-table/put! *coercion-table* (list from to) coercion))

(define (get-coercion from to)
  (hash-table/get *coercion-table* (list from to) #f))
