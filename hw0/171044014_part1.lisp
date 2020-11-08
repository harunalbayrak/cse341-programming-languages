;;; HARUN ALBAYRAK
;;; 171044014
;;; CSE 341

(let ((in (open "nested_list.txt" :if-does-not-exist nil)))
    (when in
        (loop for line = (read-line in nil)
            while line 
                do (setf *my-string* line)
        )
        (close in)
    )
)

(defvar *my-list* (list))
(defvar *flag* 0)
(defvar *length-1* (- (length *my-string*) 1))
(defvar *lll* 0)

(loop for x from 0 to *length-1*
    do (if (or (string= (char *my-string* x) "(") (string= (char *my-string* x) ")") (string= (char *my-string* x) " "))
        (setf *flag* (+ x 1))
        (progn 
            (if (not (= x *length-1*))
                (if (or (string= (char *my-string* (+ x 1)) "(") (string= (char *my-string* (+ x 1)) ")") (string= (char *my-string* (+ x 1)) " "))
                    (setf *lll* 0)
                    (setf *lll* 1)
                )
                ()
            )
            (if (= *lll* 0)
                (progn
                    (setq *sub* (subseq *my-string* *flag* (+ x 1)))
                    (push *sub* *my-list*)
                )
                ()
            )
        )
    )
)

(setf *my-list* (reverse *my-list*))

(with-open-file (my-stream 
    "flattened_list.txt"
    :direction :output
    :if-exists :supersede)

    (loop for x from 0 to (- (length *my-list*) 1)
        do (princ (nth x *my-list*) my-stream)
        do (princ " " my-stream)
    )
    ;;;(princ *edited-string* my-stream)
)

