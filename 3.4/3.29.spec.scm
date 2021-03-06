(load "3.29.scm")

(define the-agenda (make-agenda))
(define and-gate-delay 1)
(define inverter-delay 1)

(describe "or-gate"
  (it "is false when A and B are false" (lambda ()
    (let ((A (make-wire))
          (B (make-wire))
          (O (make-wire)))
      (set-signal! A 0)
      (set-signal! B 0)
      (let ((gate (or-gate A B O)))
        (propagate)
        (assert 0 (get-signal O))))))

  (it "is true when just A is true" (lambda ()
    (let ((A (make-wire))
          (B (make-wire))
          (O (make-wire)))
      (set-signal! A 1)
      (set-signal! B 0)
      (let ((gate (or-gate A B O)))
        (propagate)
        (assert 1 (get-signal O))))))

  (it "is true when just B is true" (lambda ()
    (let ((A (make-wire))
          (B (make-wire))
          (O (make-wire)))
      (set-signal! A 0)
      (set-signal! B 1)
      (let ((gate (or-gate A B O)))
        (propagate)
        (assert 1 (get-signal O))))))

  (it "is true when both A and B are true" (lambda ()
    (let ((A (make-wire))
          (B (make-wire))
          (O (make-wire)))
      (set-signal! A 1)
      (set-signal! B 1)
      (let ((gate (or-gate A B O)))
        (propagate)
        (assert 1 (get-signal O))))))
)
