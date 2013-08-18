(define (adjoin-set x set)
  (cons x set))

(define (union-set set1 set2)
  (append set1 set2))

; element-of-set? and intersection-set are unchanged


; element-of-set? remains O(n) but will perform worse as more duplicates are added as it creates more elements to traverse.
; adjoin-set becomes O(1) because element-of-set? can be removed.
; intersection-set remains O(n^2) but like element-of-set? will perform worse with more duplicates.
; union-set becomes O(n) because it is no longer using adjoin-set with element-of-set? in it.
;
; This implementation is better in a write heavy application where you rarely care about checking what is inside the list.
