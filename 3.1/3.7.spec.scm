(load "3.7.scm")

(describe "make-joint"
  (it "won't let you withdraw without the correct password" (lambda ()
    (define acc (make-account 100 'secret-password))
    (define joint-acc (make-joint acc 'secret-password 'new-secret-password))
    (assert (string=? "Incorrect password" 
                      ((joint-acc 'some-other-password 'withdraw) 50)))))

  (it "lets you withdraw with the correct password" (lambda ()
    (define acc (make-account 100 'secret-password))
    (define joint-acc (make-joint acc 'secret-password 'new-secret-password))
    (assert (= 50 ((joint-acc 'new-secret-password 'withdraw) 50)))))

  (it "won't let you deposit without the correct password" (lambda ()
    (define acc (make-account 100 'secret-password))
    (define joint-acc (make-joint acc 'secret-password 'new-secret-password))
    (assert (string=? "Incorrect password" 
                      ((joint-acc 'some-other-password 'deposit) 50)))))

  (it "lets you deposit with the correct password" (lambda ()
    (define acc (make-account 100 'secret-password))
    (define joint-acc (make-joint acc 'secret-password 'new-secret-password))
    (assert (= 150 ((joint-acc 'new-secret-password 'deposit) 50)))))
)
