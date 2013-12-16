(load "3.3.scm")

(describe "make-account"
  (it "won't let you withdraw without the correct password" (lambda ()
    (define acc (make-account 100 'secret-password))
    (assert (string=? "Incorrect password" 
                      ((acc 'some-other-password 'withdraw) 50)))))

  (it "lets you withdraw with the correct password" (lambda ()
    (define acc (make-account 100 'secret-password))
    (assert (= 50 ((acc 'secret-password 'withdraw) 50)))))

  (it "won't let you deposit without the correct password" (lambda ()
    (define acc (make-account 100 'secret-password))
    (assert (string=? "Incorrect password" 
                      ((acc 'some-other-password 'deposit) 50)))))

  (it "lets you deposit with the correct password" (lambda ()
    (define acc (make-account 100 'secret-password))
    (assert (= 150 ((acc 'secret-password 'deposit) 50)))))
)
