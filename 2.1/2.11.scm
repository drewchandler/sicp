; | Xl | Xu | Yl | Yu |
; +----+----+----+----+
; | +  | +  | +  | +  |
; | -  | +  | +  | +  |
; | -  | -  | +  | +  |
; +----+----+----+----+
; | +  | +  | -  | +  |
; | -  | +  | -  | +  |
; | -  | -  | -  | +  |
; +----+----+----+----+
; | +  | +  | -  | -  |
; | -  | +  | -  | -  |
; | -  | -  | -  | -  |

; F-this...
;
; basically something like this

(define (mul-interval x y)
  (let ((xl (lower-bound x))
        (xu (upper-bound x))
        (yl (lower-bound y))
        (yu (upper-bound y)))
    (cond
      ((and (> xl 0)
            (> xu 0)
            (> ul 0)
            (> uu 0))
       (make-interval (* xl yl) (* xu yu)))
      ...
    )))
