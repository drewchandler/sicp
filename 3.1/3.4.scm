(define (make-account balance password)
  (let ((failed-attempts 0))
    (define (withdraw amount)
      (set! failed-attempts 0)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))
    (define (deposit amount)
      (set! failed-attempts 0)
      (set! balance (+ balance amount))
      balance)
    (define (incorrect-password x)
      (set! failed-attempts (+ failed-attempts 1))
      (cond ((>= failed-attempts 7) (call-the-cops)))
      "Incorrect password")
    (define (dispatch p m)
      (if (eq? p password)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request -- MAKE-ACCOUNT" m)))
        incorrect-password))
    dispatch))
