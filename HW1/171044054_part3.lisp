;; written by
;; Bilal Bayrakdar

;; it prints the colltaz sequence of a number
;; into the given stream
(defun collatz (str num)
        (format str "~d " num )
        (if (and (> num 1) (oddp num))
            (collatz str (+ (* num 3) 1)))
            (if (and (> num 1) (evenp num)) 
            (collatz str (setq num (/ num 2)))))

;; it starts the recursive collatz function
(defun cltz-st (file num)
    (with-open-file (stream file :direction :output :if-exists :append :if-does-not-exist :create)
        (format stream "~d: " num)
        (collatz stream num)
        (format stream "~%")
    ))


;; it reads th given file returns list of integer elements inside list
(defun parse-num (file)
    (defvar 1b nil)
    (defvar num nil)
    (defvar res nil)
    (defvar lst nil)
    (with-open-file (stream file :direction :output :if-exists :append)
        (format stream " "))
    (with-open-file (stream file)
        (loop for char = (read-char stream nil) 
        while char
        if (and (not (equal num nil)) (char= char #\space))
        do (progn 
                (setq res (parse-integer (coerce (reverse num) '(string))))
                ;; (format t "num: ~d ~%" res)
                (push res lst )
                (setq num nil)
            ) 
        if (and (char/= char #\space) (numberp (parse-integer (string char))))
        do (progn
            ;; (print "second if~%")
            (push char num)             
            ;; (format t "~a ~%" num)
            (setq 1b char))))
            lst)

;; it calls pre defined functions above to 
;; handle the writing collatz into file
(defun opr (file rFile)
    (with-open-file (stream file :direction :output :if-exists :supersede :if-does-not-exist :create)
            (format stream ""))
    (let ((a 1))
        (dolist (x (reverse (parse-num rFile)))
            (if (< a 6)
                (progn
                    (cltz-st file x)
                    (incf a)        
                ))
        )))

(defvar file "collatz_outputs.txt")
(defvar rFile "integer_inputs.txt")
(opr file rFile)