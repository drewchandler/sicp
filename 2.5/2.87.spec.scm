(load "get-put.scm")
(load "tagging.scm")
(load "number-packages.scm")
(load "polynomial-package.scm")

(describe "=zero?"
  (it "works for polynomials" (lambda ()
    (assert (not (=zero? (make-poly 'x (list (list (make-scheme-number 1)
                                                   (make-scheme-number 1)))))))
    (assert (=zero? (make-poly 'x '())))
    (assert (=zero? (make-poly 'x (list (list (make-scheme-number 1) (make-scheme-number 0))))))
  ))
)
