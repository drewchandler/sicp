(load "3.22.scm")

(describe "empty-queue?"
  (it "starts off empty" (lambda ()
    (assert (empty-queue? (make-queue)))))
  (it "stops being empty when you add something to it" (lambda ()
    (assert (not (empty-queue? (insert-queue! (make-queue) 'a)))))))

(describe "front-queue"
  (it "errors when the queue is empty" (lambda ()
    (assert-error (lambda () (front-queue (make-queue))) "FRONT called with an empty queue")))
  (it "gives the front of a non-empty queue" (lambda ()
    (assert (eq? 'a (front-queue (insert-queue! (make-queue) 'a)))))))

(describe "delete-queue!"
  (it "errors when the queue is empty" (lambda ()
    (assert-error (lambda () (delete-queue! (make-queue))) "DELETE! called with an empty queue")))
  (it "gives the queue with the front item removed" (lambda ()
    (assert (eq? 'b (front-queue (delete-queue! (insert-queue! (insert-queue! (make-queue) 'a) 'b))))))))
