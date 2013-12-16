(load "3.2.scm")
(load "3.4.scm")

(define (repeat n f)
  (cond 
    ((not (zero? n)) (f)(repeat (- n 1) f))))

(define cops-called #f)
(define (call-the-cops) (set! cops-called #t))

(describe "make-account"
  (it "calls the cops if you access the account with the wrong password 7 consecutive times" (lambda ()
    (define acc (make-account 100 'secret-password))
    (repeat 7 (lambda () ((acc 'some-other-password 'deposit) 50)))

    (assert cops-called)))

  (it "calls the cops if you access the account with the wrong password 7 consecutive times" (lambda ()
    (set! cops-called #f)
    (define acc (make-account 100 'secret-password))
    (repeat 6 (lambda () ((acc 'some-other-password 'deposit) 50)))
    ((acc 'secret-password 'deposit) 50)
    ((acc 'some-other-password 'deposit) 50)

    (assert (not cops-called))))
)
