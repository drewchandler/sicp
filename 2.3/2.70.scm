(load "2.68.scm")
(load "2.69.scm")

(define word-freq '((NA 16)
                    (YIP 9)
                    (SHA 3)
                    (JOB 2)
                    (GET 2)
                    (A 2)
                    (BOOM 1)
                    (WAH 1)))

(define message '(
  Get a job
  Sha na na na na na na na na
  Get a job
  Sha na na na na na na na na
  Wah yip yip yip yip yip yip yip yip yip
  Sha boom))

(define huff-tree (generate-huffman-tree word-freq))

(define encoded-message (encode message huff-tree))

(display (length encoded-message))
; 84
;
; 3 bits per word
; 36 words * 3 bits = 108
