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


(define (sum-of-squares i j) (+ (expt i 2) (expt j 2)))

(define pairs-by-sum-of-squares
  (weighted-pairs (lambda (i j) (sum-of-squares i j)) integers integers))

(define (sum-of-squares-times-tre s)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1))
        (s2 (stream-ref s 2)))
    (let ((s0weight (sum-of-squares (car s0) (cadr s0)))
          (s1weight (sum-of-squares (car s1) (cadr s1)))
          (s2weight (sum-of-squares (car s2) (cadr s2))))

      (if (= s0weight s1weight s2weight)
        (cons-stream (list s0 s1 s2) (sum-of-squares-times-tre (stream-cdr s)))
        (sum-of-squares-times-tre (stream-cdr s))))))

(define sum-of-squares-times-tre-stream (sum-of-squares-times-tre pairs-by-sum-of-squares))
