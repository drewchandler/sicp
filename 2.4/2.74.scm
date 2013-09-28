; a.
(define (get-record personel-file employee-name)
  (let ((file-division (division personel-file)))
    (tag-division ((get 'get-record file-division)
                   (data personel-file) employee-name)
                  division))

(define (division record)
  (car record))

(define (data record)
  (cdr record))

(define (tag-devision record division)
  (car division record))

; They must tag their file with their division name and provide their own
; implementation of get-record.

; b.
(define (get-salary employee-record)
  (apply (get 'get-salary (division employee-record)) (data employee-record)))

; Rather than forcing them to tag the division of everything, we can just tag
; records when we pull them out of the file

; c.
(define (find-employee-record division-files employee-name)
  (if (null? division-files)
    '()
    (let ((employee-record (get-record (car division-files) employee-name)))
      (if (null? employee-record)
        (find-employee-record (cdr division-files) employee-name)
        employee-record))))

; d.
; The new company would need to create a package that would provide get-record
; and get-salary for their records.
