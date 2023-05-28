;type tool
;debugflags trace

;; This plugin converts tags into LRC format
;; Just execute this and copy the output into a text file

;; Format time (seconds) as mm:ss.xx
(defun time-format (sec)
  (let* 
    (
        (seconds (truncate sec))
        (mm (truncate (/ seconds 60)))
        (ss (rem seconds 60))
        (xx (truncate (* (- sec (truncate sec)) 1000)))
    )
    (format nil "~a:~a.~a" (pad mm) (pad ss) (pad3 xx))
  )
)

;; Reurn number as string with at least 2 digits
(defun pad (num)
  (format nil "~a~a" (if (< num 10) 0 "") num)
)

(defun pad3 (num)
  (format nil "~a~a" (if (< num 100) 0 "") (pad num))
)

;; Get labels from first label track
( format t "[ti:]~%[ar:]")
(let ((labels (second (first (aud-get-info "labels")))))
  (dolist (label labels)
    (setf timeS (time-format (first label)))
    (setf timeE (time-format (second label)))
;;    (format t "[~a] : ~s~%" time (third label))))
    (setf timeS (time-format (first label)))
;;  (format t (if (string= (third label) "^") "~%[~a]" "<~a>~a<~a>") timeS (third label) timeE)))
    (format t (if (string= (third label) "^") "~%[~a]" (if (string= (third label) "$") "\
~%[~a]" "<~a>~a<~a>")) timeS (third label) timeE)))

(format nil "Click OK to view LRC.")