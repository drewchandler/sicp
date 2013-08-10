(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

(define frame (make-frame
                (make-vect 0 0)
                (make-vect .99 0)
                (make-vect 0 .99)))

(define (frame-painter frame)
  (let ((frame-map (frame-coord-map frame)))
    (let ((bottom-left (frame-map (make-vect 0 0)))
          (top-left (frame-map (make-vect 0 1)))
          (bottom-right (frame-map (make-vect 1 0)))
          (top-right (frame-map (make-vect 1 1))))
      (segments->painter
        (list
          (make-segment bottom-left top-left)
          (make-segment top-left top-right)
          (make-segment top-right bottom-right)
          (make-segment bottom-right bottom-left))))))

(paint (frame-painter frame))

(define (x-painter frame)
  (let ((frame-map (frame-coord-map frame)))
    (let ((bottom-left (frame-map (make-vect 0 0)))
          (top-left (frame-map (make-vect 0 1)))
          (bottom-right (frame-map (make-vect 1 0)))
          (top-right (frame-map (make-vect 1 1))))
    (segments->painter
      (list
        (make-segment bottom-right top-left)
        (make-segment bottom-left top-right))))))

(paint (x-painter frame))

(define (diamond-painter frame)
  (let ((frame-map (frame-coord-map frame)))
    (let ((bottom (frame-map (make-vect 0.5 0)))
          (top (frame-map (make-vect 0.5 1)))
          (right (frame-map (make-vect 1 0.5)))
          (left (frame-map (make-vect 0 0.5))))
    (segments->painter
      (list
        (make-segment bottom left)
        (make-segment left top)
        (make-segment top right)
        (make-segment right bottom))))))

(paint (diamond-painter frame))

; Not gonna do wave...
