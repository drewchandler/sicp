(load "3.23.scm")

(describe "empty-deque?"
  (it "starts off empty" (lambda ()
    (assert (empty-deque? (make-deque)))))
  (it "stops being empty after an insert to the front" (lambda ()
    (assert (not (empty-deque? (front-insert-deque! (make-deque) 'a))))))
  (it "is empty after removing the last item from the front" (lambda ()
    (assert (empty-deque? (front-delete-deque! (front-insert-deque! (make-deque) 'a))))))
  (it "stops being empty after an insert to the rear" (lambda ()
    (assert (not (empty-deque? (rear-insert-deque! (make-deque) 'a))))))
  (it "is empty after removing the last item from the rear" (lambda ()
    (assert (empty-deque? (rear-delete-deque! (front-insert-deque! (make-deque) 'a)))))))

(describe "front-deque"
  (it "errors when the deque is empty" (lambda ()
    (assert-error (lambda () (front-deque (make-deque))) "FRONT called with empty deque")))
  (it "return the item at the front when not empty" (lambda ()
    (assert (eq? 'a (front-deque (front-insert-deque! (make-deque) 'a)))))))

(describe "rear-deque"
  (it "errors when the deque is empty" (lambda ()
    (assert-error (lambda () (rear-deque (make-deque))) "REAR called with empty deque")))
  (it "return the item at the rear when not empty" (lambda ()
    (assert (eq? 'a (rear-deque (front-insert-deque! (make-deque) 'a)))))))

(describe "front-insert-deque!"
  (it "works with an empty queue" (lambda ()
    (assert (eq? 'a (front-deque (front-insert-deque! (make-deque) 'a))))))
  (it "works with a non-empty queue" (lambda ()
    (assert (eq? 'b (front-deque (front-insert-deque! (front-insert-deque! (make-deque) 'a) 'b)))))))

(describe "rear-insert-deque!"
  (it "works with an empty queue" (lambda ()
    (assert (eq? 'a (rear-deque (rear-insert-deque! (make-deque) 'a))))))
  (it "works with a non-empty queue" (lambda ()
    (assert (eq? 'b (rear-deque (rear-insert-deque! (rear-insert-deque! (make-deque) 'a) 'b)))))))

(describe "front-delete-deque!"
  (it "errors with an empty deque" (lambda ()
    (assert-error (lambda () (front-delete-deque! (make-deque))) "FRONT-DELETE called with empty deque")))
  (it "deletes the item at the front" (lambda ()
    (assert (eq? 'a (front-deque (front-delete-deque! (front-insert-deque! (front-insert-deque! (make-deque) 'a) 'b))))))))

(describe "rear-delete-deque!"
  (it "errors with an empty deque" (lambda ()
    (assert-error (lambda () (rear-delete-deque! (make-deque))) "REAR-DELETE called with empty deque")))
  (it "deletes the item at the rear" (lambda ()
    (assert (eq? 'a (rear-deque (rear-delete-deque! (rear-insert-deque! (rear-insert-deque! (make-deque) 'a) 'b))))))))
