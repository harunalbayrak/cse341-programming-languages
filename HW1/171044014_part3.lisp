;;; HARUN ALBAYRAK
;;; 171044014
;;; CSE 341

(let ((in (open "integer_inputs.txt" :if-does-not-exist nil)))
    (when in
        (loop for line = (read-line in nil)
            while line 
                do (setf *my-string* line)
        )
        (close in)
    )
)

(defvar *list* 	(list))

(defvar *flag* 0)
(defvar *length-1* (- (length *my-string*) 1))
(loop for x from 0 to *length-1*
    do (if (string= (char *my-string* x) " ")
        (progn
            (push (parse-integer (subseq *my-string* *flag* x)) *list*)
            (setf *flag* (+ x 1))
        )
        (if (= x *length-1*)
            (push (parse-integer (subseq *my-string* *flag* (+ x 1))) *list*)
            ()
        )
    )
)

(setf *list* (reverse *list*))

(defvar *maximum-len* 0)
(if (> (length *list*) 5)
    (setf *maximum-len* 5)
    (setf *maximum-len* (length *list*))
)

(with-open-file (my-stream 
    "collatz_outputs.txt"
    :direction :output
    :if-exists :supersede)
    (defvar *list2* *list*)
    (defvar *string-list2* )
    (loop for x from 0 to (- *maximum-len* 1)
        do (princ (nth x *list2*) my-stream)
        do (princ ": " my-stream)
        do (loop
            (princ (nth x *list2*) my-stream)
            (princ " " my-stream)
            (if (= (mod (nth x *list2*) 2) 0)
                (setf (nth x *list2*) (/ (nth x *list2*) 2))
                (setf (nth x *list2*) (+ (* (nth x *list2*) 3) 1))
            )
            (when (<= (nth x *list2*) 1) (return x))
        )
        (princ (nth x *list2*) my-stream)
        (princ #\linefeed my-stream)
    )
)