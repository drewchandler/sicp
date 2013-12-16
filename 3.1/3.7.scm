(load "3.3.scm")

(define (make-joint account password joint-password)
  (define (incorrect-password x) "Incorrect password")
  (define (dispatch p m)
    (if (eq? p joint-password)
      (account password m)
      incorrect-password))
  dispatch)
