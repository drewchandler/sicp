(define (add-streams s1 s2)
  (stream-map + s1 s2))
(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))
(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    (pairs (stream-cdr s) (stream-cdr t)))))

(define (merge-weighted weight s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
          (let ((s1car (stream-car s1))
                (s2car (stream-car s2)))
            (cond ((<= (weight s1car) (weight s2car))
                   (cons-stream s1car (merge-weighted weight (stream-cdr s1) s2)))
                  (else
                    (cons-stream s2car (merge-weighted weight s1 (stream-cdr s2)))))))))

(define (weighted-pairs weight s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (merge-weighted
      (lambda (pair) (weight (car pair) (cadr pair)))
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (weighted-pairs weight (stream-cdr s) (stream-cdr t)))))

(define (divisible? x y) (= (remainder x y) 0))
(define (not-divisible-by-2-3-or-5 x)
  (and (not (divisible? x 2))
       (not (divisible? x 3))
       (not (divisible? x 5))))

(define a (weighted-pairs (lambda (i j) (+ i j)) integers integers))
(define b (stream-filter
            (lambda (pair) (and (not-divisible-by-2-3-or-5 (car pair))
                                (not-divisible-by-2-3-or-5 (cadr pair))))
            (weighted-pairs (lambda (i j) (+ (* 2 i) (* 3 j) (* 5 i j))) integers integers)))
