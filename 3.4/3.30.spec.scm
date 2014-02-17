(load "3.30.scm")

(define the-agenda (make-agenda))
(define and-gate-delay 1)
(define inverter-delay 1)
(define or-gate-delay 1)

(describe "ripple-carry-adder"
  (it "adds stuff" (lambda ()
    (let ((a1 (make-wire))
          (a2 (make-wire))
          (b1 (make-wire))
          (b2 (make-wire))
          (s1 (make-wire))
          (s2 (make-wire))
          (c-in (make-wire))
          (c-out (make-wire)))
      (ripple-carry-adder (list a1 a2) (list b1 b2) c-in (list s1 s2) c-out)
      (set-signal! b1 1)
      (set-signal! c-in 1)
      (propagate)
      (assert (= 0 (get-signal s1)) "s1")
      (assert (= 1 (get-signal s2)) "s1")
      (assert (= 0 (get-signal c-out)) "c-out")))))
