(define (make-deque)
  (cons '() '()))

(define (front-ptr deque)
  (car deque))

(define (rear-ptr deque)
  (cdr deque))

(define (make-node item)
  (cons item (cons '() '())))

(define (node-contents node)
  (car node))

(define (prev-node node)
  (cadr node))

(define (next-node node)
  (cddr node))

(define (set-prev-node! node prev)
  (set-car! (cdr node) prev))

(define (set-next-node! node next)
  (set-cdr! (cdr node) next))

(define (set-front-ptr! deque item)
  (set-car! deque item))

(define (set-rear-ptr! deque item)
  (set-cdr! deque item))

(define (empty-deque? deque)
  (or (null? (front-ptr deque))
      (null? (rear-ptr deque))))

(define (front-deque deque)
  (if (empty-deque? deque)
    (error "FRONT called with empty deque")
    (node-contents (front-ptr deque))))

(define (rear-deque deque)
  (if (empty-deque? deque)
    (error "REAR called with empty deque")
    (node-contents (rear-ptr deque))))

(define (front-insert-deque! deque item)
  (let ((new-node (make-node item)))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-node)
           (set-rear-ptr! deque new-node))
          (else
            (let ((old-front (front-ptr deque)))
              (set-next-node! new-node old-front)
              (set-prev-node! old-front new-node)
              (set-front-ptr! deque new-node))))
    deque))

(define (rear-insert-deque! deque item)
  (let ((new-node (make-node item)))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-node)
           (set-rear-ptr! deque new-node))
          (else
            (let ((old-rear (rear-ptr deque)))
              (set-prev-node! new-node old-rear)
              (set-next-node! old-rear new-node)
              (set-rear-ptr! deque new-node))))
    deque))

(define (front-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "FRONT-DELETE called with empty deque"))
        (else
          (let ((front (front-ptr deque))
                (new-front (next-node (front-ptr deque))))
            (set-front-ptr! deque new-front)
            (set-next-node! front '())
            (if (pair? new-front) (set-prev-node! new-front '()))
            deque))))

(define (rear-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "REAR-DELETE called with empty deque"))
        (else
          (let ((rear (rear-ptr deque))
                (new-rear (prev-node (rear-ptr deque))))
            (set-rear-ptr! deque new-rear)
            (set-prev-node! rear '())
            (if (pair? new-rear) (set-next-node! new-rear '()))
            deque))))
