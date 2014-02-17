(load "ch3.scm")

(define (squarer a b)
  (define (process-new-value)
    (if (has-value? b)
        (if (< (get-value b) 0)
            (error "square less than 0 -- SQUARER" (get-value b))
            (set-value! a (sqrt (get-value b)) me))
        (if (has-value? a)
          (set-value! b (expt (get-value a) 2) me))))
  (define (process-forget-value)
    (forget-value! a me)
    (forget-value! b me)
    (process-new-value))
  (define (me request)
    (cond ((eq? request 'I-have-a-value)
           (process-new-value))
          ((eq? request 'I-lost-my-value)
           (process-forget-value))
          (else
            (error "Unknown request -- SQUARER" request))))
  (connect a me)
  (connect b me)
  me)

(define A (make-connector))
(define B (make-connector))

(squarer A B)

(probe "A" A)
(probe "B" B)

(set-value! A 2 'user)

(forget-value! A 'user)
(forget-value! B 'user)

(set-value! B 100 'user)
