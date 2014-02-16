(load "3.25.scm")

(describe "1 dimensional table"
  (it "gives false when the key is not found" (lambda ()
    (assert (not (lookup '(a) (make-table))))))

  (it "finds an existing value" (lambda ()
    (let ((table (make-table)))
      (insert! '(a) 'b table)
      (assert (eq? 'b (lookup '(a) table)))))))

(describe "2 dimensional table"
  (it "gives false when the key is not found" (lambda ()
    (assert (not (lookup '(a b) (make-table))))))

  (it "finds an existing value" (lambda ()
    (let ((table (make-table)))
      (insert! '(a b) 'c table)
      (assert (eq? 'c (lookup '(a b) table)))))))

(describe "5 dimensional table"
  (it "gives false when the key is not found" (lambda ()
    (assert (not (lookup '(a b c d e) (make-table))))))

  (it "finds an existing value" (lambda ()
    (let ((table (make-table)))
      (insert! '(a b c d e) 'f table)
      (assert (eq? 'f (lookup '(a b c d e) table)))))))
