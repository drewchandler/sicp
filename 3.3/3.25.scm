(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup-iter keys table)
      (if (null? keys)
        (cdr table)
        (let ((subtable (assoc (car keys) (cdr table))))
          (if subtable
            (lookup-iter (cdr keys) subtable)
            #f))))

    (define (lookup keys)
      (lookup-iter keys local-table))

    (define (insert-iter! keys value table)
      (if (null? keys)
        (set-cdr! table value)
        (let ((subtable (assoc (car keys) (cdr table))))
          (if subtable
            (insert-iter! (cdr keys) value subtable)
            (let ((new-subtable (list (car keys))))
              (set-cdr! table (cons new-subtable (cdr table)))
              (insert-iter! (cdr keys) value new-subtable)))))
      'ok)

    (define (insert! keys value)
      (insert-iter! keys value local-table))

    (define (dispatch m)
      (cond ((eq? m 'lookup) lookup)
            ((eq? m 'insert!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define (lookup keys table)
  ((table 'lookup) keys))

(define (insert! keys value table)
  ((table 'insert!) keys value))

