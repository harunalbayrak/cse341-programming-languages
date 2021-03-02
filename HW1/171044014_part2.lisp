;;; HARUN ALBAYRAK
;;; 171044014
;;; CSE 341

(let ((in (open "boundries.txt" :if-does-not-exist nil)))
    (when in
        (loop for line = (read-line in nil)
            while line 
                do (setf *my-string* line)
        )
        (close in)
    )
)

(defvar *flag* 0)
(defvar *length-1* (- (length *my-string*) 1))
(loop for x from 0 to *length-1*
    do (if (string= (char *my-string* x) " ")
        (progn
            (defvar *boundary1* (subseq *my-string* *flag* x))
            (setf *flag* x)
        )
        (if (= x *length-1*)
            (defvar *boundary2* (subseq *my-string* *flag* (+ x 1)))
            ()
        )
    )
)
(defvar *int-boundary1* (parse-integer *boundary1*))
(defvar *int-boundary2* (parse-integer *boundary2*))

(defvar *prime* 1)
(defun isPrime (num)
    (loop for x from 2 to (sqrt num)
        do (if (= (mod num x) 0)
            (progn
                (setf *prime* 0)
                (return x)
            )
            ()
        )
    )

    (if (<= num 1)
        (setf *prime* 0)
    )
)

(defvar *semi-prime* -1)
(defun isSemiPrime (num)
    (loop for x from 2 to num
        do (loop
            (if (= (mod num x) 0)
                ()
                (return x)
            )
            (setf *semi-prime* (+ *semi-prime* 1))
            (setf num (/ num x))
        )
    )
)

(with-open-file (my-stream 
    "primedistribution.txt"
    :direction :output
    :if-exists :supersede)
    (loop for y from *int-boundary1* to *int-boundary2*
        do (isPrime y)
        do (if (= *prime* 1)
            (progn
                (princ y my-stream)
                (princ " is Prime" my-stream)
                (princ #\linefeed my-stream)
            )
            (progn
                (isSemiPrime y)
                (if (= *semi-prime* 1)
                    (progn
                        (princ y my-stream)
                        (princ " is Semi-prime" my-stream)
                        (princ #\linefeed my-stream)
                    )
                    ()
                )
            )
        )
        do (setf *prime* 1)
        do (setf *semi-prime* -1)
    )
)