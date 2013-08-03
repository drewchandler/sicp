(define (make-point x y)
  (cons x y))
(define (x-point point)
  (car point))
(define (y-point point)
  (cdr point))

; (define (make-rect x1 y1 x2 y2)
;   (cons (make-point x1 y1)
;         (make-point x2 y2)))
;
; (define (p1-rect r)
;   (car r))
;
; (define (p2-rect r)
;   (cdr r))
;
; (define (width-rect r)
;   (- (x-point (p2-rect r))
;      (x-point (p1-rect r))))
;
; (define (height-rect r)
;   (- (y-point (p2-rect r))
;      (y-point (p1-rect r))))

(define (make-rect x1 y1 x2 y2)
  (cons (make-point (min x1 x2)
                    (max y1 y2))
        (cons (- x2 x1)
              (- y2 y1))))

(define (width-rect r)
  (car (cdr r)))
(define (height-rect r)
  (cdr (cdr r)))

(define (area-rect r)
  (* (width-rect r)
     (height-rect r)))

(define (perimeter-rect r)
  (* 2 (+ (width-rect r)
          (height-rect r))))
