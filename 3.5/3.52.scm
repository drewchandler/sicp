(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream
       low
       (stream-enumerate-interval (+ low 1) high))))

(define (display-line x)
  (newline)
  (display x))

(define (show x)
  (display-line x)
  x)

(define (display-stream s)
  (stream-for-each display-line s))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter pred
                                     (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))

(define sum 0)
;Value: sum

(define (accum x)
  (set! sum (+ x sum))
  sum)
;Value: accum

(define seq (stream-map accum (stream-enumerate-interval 1 20)))
;Value: seq

(define y (stream-filter even? seq))
;Value: y

(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))
;Value: z

(stream-ref y 7)
;Value: 136

(display-stream z)
10
15
45
55
105
120
190
210
;Value: done

; The sum is 136 after evaluating y and 210 after evaluating z.
;
; Yes. Without memoizing, the delayed object would need to be evaluated each
; time which would result in accum being called and sum being incremented
