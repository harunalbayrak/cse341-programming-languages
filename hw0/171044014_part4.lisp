;;; HARUN ALBAYRAK
;;; 171044014
;;; CSE 341

(defvar *list* 	(list))
(let ((in (open "paragraph.txt" :if-does-not-exist nil)))
    (when in
        (loop for line = (read-line in nil)
            while line 
                do (setf *my-string* line)
                (push line *list*)
        )
        (close in)
    )
)

(setf *list* (reverse *list*))
(defvar *chars* (list "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"
     "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" " "))
(defvar *num-char-list* (list 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))

(loop for x from 0 to (- (length *list*) 1)
    do (setf *string-x* (nth x *list*))
    do (loop for y from 0 to (- (length *string-x*) 1)
        do (loop for z from 0 to (- (length *chars*) 1)
            do (if (string= (char *string-x* y) (nth z *chars*))
                (setf (nth z *num-char-list*) (+ (nth z *num-char-list*) 1))
                ()
            )
        )
    )
)


(defparameter *my-hash* (make-hash-table :test 'equal))
(setf (gethash "a" *my-hash*) 0)
;;;(format t "~a ~%" (gethash "a" *my-hash*))

(loop for x from 0 to (- (length *num-char-list*) 1)
    do (setf (gethash (nth x *chars*) *my-hash*) (nth x *num-char-list*))
    ;;;do (format t "~a : ~a ~%" (nth x *chars*) (nth x *num-char-list*))
)

(loop for x from 0 to (- (length *num-char-list*) 1)
    do (format t "~a " (gethash (nth x *chars*) *my-hash*))
)

(defclass HuffmanNode()
    (data chr left right)
)

(defvar *dd-list* (list))
(loop for x from 0 to (- (length *num-char-list*) 1)
    do (defparameter *dd* (make-instance 'HuffmanNode))
    do (setf (slot-value *dd* 'chr) (nth x *chars*))
    do (setf (slot-value *dd* 'data) (nth x *num-char-list*))
    do (setf (slot-value *dd* 'left) "null")
    do (setf (slot-value *dd* 'right) "null")

    do (push *dd* *dd-list*)
)
(setf *dd-list* (reverse *dd-list*))

(defparameter *root* (make-instance 'HuffmanNode))
(setf (slot-value *root* 'left) "null")
(setf (slot-value *root* 'right) "null")

(loop
    do (if (> (length *dd-list*) 1)
        (progn
            (defparameter *x* (make-instance 'HuffmanNode))
            (setf *x* (car *dd-list*))
            (setf (slot-value *x* 'left) "null")
            (setf (slot-value *x* 'right) "null")
            (setf *dd-list* (cdr *dd-list*))

            (defparameter *y* (make-instance 'HuffmanNode))
            (setf *y* (car *dd-list*))
            (setf (slot-value *y* 'left) "null")
            (setf (slot-value *y* 'right) "null")
            (setf *dd-list* (cdr *dd-list*))

            (defparameter *f* (make-instance 'HuffmanNode))
            (setf (slot-value *f* 'chr) "-")
            (setf (slot-value *f* 'left) "null")
            (setf (slot-value *f* 'right) "null")
            (setf (slot-value *f* 'data) (+ (slot-value *x* 'data) (slot-value *y* 'data)))
            (setf (slot-value *f* 'left) *x*)
            (setf (slot-value *f* 'right) *y*)

            (setf *root* *f*)

            (nconc *dd-list* (list *f*))
        )
        (return)
    )
)

(terpri)

(with-open-file (my-stream 
    "huffman_codes.txt"
    :direction :output
    :if-exists :supersede)
    (princ "I tried a lot, but it did not work." my-stream)
)

(defun printHuffmanTree (root *string*)
    (handler-case
    (error "failed")
    (simple-error (e)
        (return 2)
    ))
    (if (and (stringp (slot-value root 'left)) (stringp (slot-value root 'right)) (every #'alpha-char-p (slot-value root 'chr)))
        (progn 
            (format t "~a : ~a" (slot-value root 'chr) *string*)
        )
        ()
    )
    
    (printHuffmanTree (slot-value root 'left) (concatenate 'string *string* "0"))
    (printHuffmanTree (slot-value root 'right) (concatenate 'string *string* "1"))
)

(printHuffmanTree *root* "")