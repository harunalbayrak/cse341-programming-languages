(defclass clause()
    (
        (clauseType :accessor clause-clauseType :initarg :clauseType)
        (head :accessor clause-head :initarg :head)
        (body :accessor clause-body :initarg :body)
        (full :accessor clause-full :initarg :full)
    )
)

(defun remove-char (character sequence)
  (let ((out ""))
    (dotimes (i (length sequence) out)
        (setf ch (char sequence i))
            (unless (char= ch character)
                (setf out (format nil "~a~a" out ch))
            )
        )
    )
)

(defun remove-nth-element (n list)
    (declare
        (type (integer 0) n)
        (type list list)
    )
    (if (or (zerop n) (null list))
        (cdr list)
        (cons (car list) (remove-nth-element (1- n) (cdr list)))
    )
)

(defun handleLine (line my-stream)
    ;(format t "~d ~%" line)
    (setf *list* (list))
    (setf *flag* 0)
    (setf *yep* 0)
    (setf *str* 0)
    (setf *num* 0)
    
    (setf line (remove-char #\“ line))
    (setf line (remove-char #\” line))
    (setf line (remove-char #\" line))
    (setf line (remove-char #\' line))
    
    (setf line (string-trim '(#\Space) line))
    
    ;(format t "~d ~%" line)

    (setf *length-1* (- (length line) 1))
    (loop for x from 0 to *length-1* do
        (if (or (string= (char line x) "(") (string= (char line x) ")"))
            (progn
                (if (and (equal *yep* 1) (string= (char line x) ")"))
                    (progn
                        (setf *yep* 0)
                        (push (subseq line *flag* x) *list*)
                        (setf *str* 0)
                    )
                )
                (push (subseq line x (+ x 1)) *list*)
                (if (string= (char line x) "(")
                    (progn
                        (setf *flag* (+ x 1))
                    )
                    ()
                )
            )
            (progn
                (if (not (string= (char line x) " "))
                    (progn
                        (if (equal *str* 0)
                            (setf *flag* x)
                        )
                        (setf *str* 1)
                        (setf *yep* 1)
                    )
                    (progn
                        (if (equal *yep* 1)
                            (progn
                                (setf *yep* 0)
                                (push (subseq line *flag* x) *list*)
                                (setf *str* 0)
                            )
                        )
                    )
                )
            )
        )
    )

    (setf *list* (reverse *list*))
    ;(format t "~d ~%" (length *list*))
    

    (setf *L* (make-instance 'clause :clauseType "NIL" :head (list) :body (list) :full (list)))

    (setf *flag* 1)
    (if (and (equal *flag* 1) (string= (nth 1 *list*) "(") (string= (nth 2 *list*) ")"))
        (progn
            ;(format t "~d ~%" *list*)
            (setf *flag* 0)
            ;(format t "~d ~%" "Query")
            (setf (clause-clauseType *L*) "Query")
            (setf *h1* (list (nth 4 *list*)))
            (setf *flag2* 1)
            ;(format t "~d ~%" (nth 15 *list*))

            (setf *h2* (list))
            (setf *ll* 1)
            (loop for x from 6 to (length *list*) do
                (if (and (equal *ll* 1) (not (string= (nth x *list*) ")")))
                    (if (equal *h2* NIL)
                        (push (nth x *list*) *h2*)
                        (push (nth x *list*) (cdr (last *h2*)))
                    )
                    (setf *ll* 0)
                )
            )

            ;(format t "~d ~%" *h1*)
            ;(format t "~d ~%" *h2*)
            (push *h2* (cdr (last *h1*)))
            (setf (clause-body *L*) *h1*)
            (setf (clause-head *L*) (list '()))
        )
    )

    (if (and (equal *flag* 1) (string= (nth 7 *list*) "(") (string= (nth 8 *list*) ")"))
        (progn
            ;(format t "~d ~%" *list*)
            (setf *flag* 0)
            ;(format t "~d ~%" "Fact")
            (setf (clause-clauseType *L*) "Fact")

            (setf *h1* (list (nth 2 *list*)))

            (setf *h2* (list))
            (setf *ll* 1)
            (loop for x from 4 to (length *list*) do
                (if (and (equal *ll* 1) (not (string= (nth x *list*) ")")))
                    (if (equal *h2* NIL)
                        (push (nth x *list*) *h2*)
                        (push (nth x *list*) (cdr (last *h2*)))
                    )
                    (setf *ll* 0)
                )
            )

            (push *h2* (cdr (last *h1*)))
            (setf (clause-head *L*) *h1*)
            (setf (clause-body *L*) (list '()))
        )
    )
    (if (and (equal *flag* 1) (string= (nth 8 *list*) "(") (string= (nth 9 *list*) ")"))
        (progn
            ;(format t "~d ~%" *list*)
            (setf *flag* 0)
            ;(format t "~d ~%" "Fact")
            (setf (clause-clauseType *L*) "Fact")

            (setf *h1* (list (nth 2 *list*)))

            (setf *h2* (list))
            (setf *ll* 1)
            (loop for x from 4 to (length *list*) do
                (if (and (equal *ll* 1) (not (string= (nth x *list*) ")")))
                    (if (equal *h2* NIL)
                        (push (nth x *list*) *h2*)
                        (push (nth x *list*) (cdr (last *h2*)))
                    )
                    (setf *ll* 0)
                )
            )

            (push *h2* (cdr (last *h1*)))
            (setf (clause-head *L*) *h1*)
            (setf (clause-body *L*) (list '()))
        )
    )
    (if (and (equal *flag* 1) (string= (nth 9 *list*) "(") (string= (nth 10 *list*) ")"))
        (progn
            ;(format t "~d ~%" *list*)
            (setf *flag* 0)
            ;(format t "~d ~%" "Fact")
            (setf (clause-clauseType *L*) "Fact")

            (setf *h1* (list (nth 2 *list*)))

            (setf *h2* (list))
            (setf *ll* 1)
            (loop for x from 4 to (length *list*) do
                (if (and (equal *ll* 1) (not (string= (nth x *list*) ")")))
                    (if (equal *h2* NIL)
                        (push (nth x *list*) *h2*)
                        (push (nth x *list*) (cdr (last *h2*)))
                    )
                    (setf *ll* 0)
                )
            )

            (push *h2* (cdr (last *h1*)))
            (setf (clause-head *L*) *h1*)
            (setf (clause-body *L*) (list '()))
        )
    )
    (if (and (equal *flag* 1) (string= (nth 10 *list*) "(") (string= (nth 11 *list*) ")"))
        (progn
            ;(format t "~d ~%" *list*)
            (setf *flag* 0)
            ;(format t "~d ~%" "Fact")
            (setf (clause-clauseType *L*) "Fact")

            (setf *h1* (list (nth 2 *list*)))

            (setf *h2* (list))
            (setf *ll* 1)
            (loop for x from 4 to (length *list*) do
                (if (and (equal *ll* 1) (not (string= (nth x *list*) ")")))
                    (if (equal *h2* NIL)
                        (push (nth x *list*) *h2*)
                        (push (nth x *list*) (cdr (last *h2*)))
                    )
                    (setf *ll* 0)
                )
            )

            (push *h2* (cdr (last *h1*)))
            (setf (clause-head *L*) *h1*)
            (setf (clause-body *L*) (list '()))
        )
    )

    (if (and (equal *flag* 1) (not (equal (nth 4 *list*) NIL)))
        (progn
            ;(format t "~d ~%" *list*)
            ;(format t "~d ~%" "Rule")
            (setf (clause-clauseType *L*) "Rule")

            (setf *h1* (list (nth 2 *list*)))

            (setf *h2* (list))
            (setf *ll* 1)
            (setf *nn* 0)
            (loop for x from 4 to (length *list*) do
                (if (and (equal *ll* 1) (not (string= (nth x *list*) ")")))
                    (progn
                        (setf *nn* (+ x 5))
                        (if (equal *h2* NIL)
                            (push (nth x *list*) *h2*)
                            (push (nth x *list*) (cdr (last *h2*)))
                        )
                    )
                    (setf *ll* 0)
                )
            )

            (setf *h3* (list (nth *nn* *list*)))

            (setf *h4* (list))
            (setf *ll* 1)
            (setf *mm* 0)
            (loop for x from (+ *nn* 2) to (length *list*) do
                (if (and (equal *ll* 1) (not (string= (nth x *list*) ")")))
                    (progn
                        (setf *mm* (+ x 4))
                        (if (equal *h4* NIL)
                            (push (nth x *list*) *h4*)
                            (push (nth x *list*) (cdr (last *h4*)))
                        )
                    )
                    (setf *ll* 0)
                )
            )

            (setf *h5* (list (nth *mm* *list*)))

            (setf *h6* (list))
            (setf *ll* 1)
            (loop for x from (+ *mm* 2) to (length *list*) do
                (if (and (equal *ll* 1) (not (string= (nth x *list*) ")")))
                    (progn
                        (if (equal *h6* NIL)
                            (push (nth x *list*) *h6*)
                            (push (nth x *list*) (cdr (last *h6*)))
                        )
                    )
                    (setf *ll* 0)
                )
            )

            ;(format t "~d ~%" *h1*)
            ;(format t "~d ~%" *h2*)
            (push *h2* (cdr (last *h1*)))
            (setf (clause-head *L*) *h1*)
            ;(format t "~d ~%" *h3*)
            ;(format t "~d ~%" *h4*)
            (push *h4* (cdr (last *h3*)))
            ;(format t "~d ~%" *h5*)
            ;(format t "~d ~%" *h6*)
            (push *h6* (cdr (last *h5*)))
            (setf *h7* (list *h3* *h5*))
            (setf (clause-body *L*) *h7*)
        )
    )

    (if (not (string= (clause-clauseType *L*) "NIL"))
        (progn
            (setf *h8* (list (clause-head *L*) (clause-body *L*)))
            (setf *h8* (list (clause-head *L*) (clause-body *L*)))
            (setf (clause-full *L*) *h8*)

            ;(format t "Type: ~d ~%" (clause-clauseType *L*))
            ;(format t "Head: ~d ~%" (clause-head *L*))
            ;(format t "Body: ~d ~%" (clause-body *L*))
            ;(format t "Full: ~d ~%" (clause-full *L*))
            ;(format t "------------------------~%")
            (list (clause-clauseType *L*) (clause-head *L*) (clause-body *L*))
        )
    )
)

(defun handleResolution (rha qba rule-body all my-stream)
    ;(format t "~d ~d ~d ~%" rha qba rule-body)
    ;(format t "~d ~%" (length rule-body))
    (setf *trueStatements* (list))
    

    (loop for i from 0 to (- (length rule-body) 1) do
        (setf *rbi* (copy-list (nth i rule-body)))
        (setf *rbi-name* (list (nth 0 *rbi*)))
        (setf *rbi-args* (copy-list (nth 1 *rbi*)))
        ;(format t "~d ~%" *rbi*)
        ;(format t "~d ~%" *rbi-args*)

        (loop for j from 0 to (- (length *rbi-args*) 1) do
            (loop for z from 0 to (- (length rha) 1) do
                (if (equal (nth j *rbi-args*) (nth z rha))
                    (setf (nth j *rbi-args*) (nth z qba))
                    ;(format t "~d ~%" (nth j *rbi-args*))
                )
            )
        )

        (push *rbi-args* (cdr (last *rbi-name*)))
        ;(format t "~d ~%" *rbi-name*)

        (setf *query-b* *rbi-name*)
        (setf *query-b-name* (nth 0 *query-b*))
        (setf *query-b-args* (nth 1 *query-b*))
        (setf *query-b-args-isVar* (list))

        ;(format t "~d ~%" *query-b*)

        (loop for y from 0 to (- (length *query-b-args*) 1) do
            (if (equal *query-b-args-isVar* NIL)
                (push (upper-case-p (char (nth y *query-b-args*) 0)) *query-b-args-isVar*)
                (push (upper-case-p (char (nth y *query-b-args*) 0)) (cdr (last *query-b-args-isVar*)))
            )
        )
        
        (loop for x from 0 to (- (length all) 1) do
            ;(format t "~d ~%" (nth x all))
            (setf *f* 1)
            (if (and (equal *f* 1) (string= (nth 0 (nth x all)) "Fact"))
                (progn
                    (setf *f* 0)
                    (setf *flag2* 1)
                    (if (and (equal *flag2* 1) (equal (nth 1 (nth x all)) *query-b*))
                        (progn
                            (setf *flag2* 0)
                            (if (equal *trueStatements* NIL)
                                (push "true" *trueStatements*)
                                (push "true" (cdr (last *trueStatements*)))
                            )
                            ;(format t "Query is true~%")
                        )
                        (if (equal *flag2* 1)
                            (progn
                                (setf *qba3* (nth 1 *query-b*))
                                ;;; bug1
                                ;(format t "~d ~%" *qba3*)
                            )
                        )
                    )
                    (setf *varPos2* (position T *query-b-args-isVar*))
                    (setf *indexVars2* (list))
                    (loop for z from 0 to (- (length *query-b-args-isVar*) 1) do
                        (if (equal (nth z *query-b-args-isVar*) NIL)
                            ()
                            (if (equal *indexVars2* NIL)
                                (push z *indexVars2*)
                                (push z (cdr (last *indexVars2*)))
                            )
                        )
                    )
                    (if (and (equal *flag2* 1) (equal (nth 0 (nth 1 (nth x all))) *query-b-name*) *varPos2*)
                        (progn
                            (setf *flag2* 0)
                            (setf *statement2* 1)
                            (loop for y from 0 to (- (length *query-b-args*) 1) do 
                                ;(format t "~d ~%" *statement*)
                                (if (and (equal (nth y *query-b-args-isVar*) NIL) (equal (nth y *query-b-args*) (nth y (nth 1 (nth 1 (nth x all))))))
                                    (progn
                                        ;(format t "~d ~%" (nth y *query-body-args*))
                                    )
                                    (if (equal (nth y *query-b-args-isVar*) NIL)
                                        (setf *statement2* 0)
                                    )
                                )
                            )
                            (if (equal *statement2* 1)
                                (loop for z from 0 to (- (length *indexVars2*) 1) do
                                    (format t "~d: ~d ~%" (nth z *query-b-args*) (nth z (nth 1 (nth 1 (nth x all)))))
                                    (princ (nth z *query-b-args*) my-stream)
                                    (princ ": " my-stream)
                                    (princ (nth z (nth 1 (nth 1 (nth x all)))) my-stream)
                                    (princ #\linefeed my-stream)
                                )
                            )
                        )
                    )
                )
            )
        )

        (setf *count* 0)
        (if (equal *trueStatements* NIL)
            ()
            (loop for x from 0 to (- (length *trueStatements*) 1) do
                (if (string= "true" (nth x *trueStatements*))
                    (progn
                        (setf *count* (+ *count* 1))
                    )
                )
            )
        )
        ;(format t "~d ~%" rule-body)
        (if (equal (length rule-body) *count*)
            (progn
                (format t "Query is true~%")
                (princ "Query is true" my-stream)
                (princ #\linefeed my-stream)
            )
        )
    )
)

(defun handleResolution2 (crb all my-stream)
    ;(format t "~d ~%" crb)

    (setf *final-args* (list))
    (setf *final-responses* (list))

    (loop for x from 0 to (- (length crb) 1) do
        (setf *rb* (copy-list (nth x crb)))
        (setf *rb-name* (nth 0 *rb*))
        (setf *rb-args* (copy-list (nth 1 *rb*)))

        ;(format t "rrbb: ~d ~%" *rb*)
        ;(format t "~d ~%" *rb-name*)
        ;(format t "~d ~%" *rb-args*)

        (setf *rb-args-isVar* (list))

        (loop for y from 0 to (- (length *rb-args*) 1) do
            (if (equal *rb-args-isVar* NIL)
                (push (upper-case-p (char (nth y *rb-args*) 0)) *rb-args-isVar*)
                (push (upper-case-p (char (nth y *rb-args*) 0)) (cdr (last *rb-args-isVar*)))
            )
        )

        (setf *varPos3* (position T *rb-args-isVar*))
        (setf *indexVars3* (list))
        (setf *indexNotVars3* (list))
        (loop for z from 0 to (- (length *rb-args-isVar*) 1) do
            (if (equal (nth z *rb-args-isVar*) NIL)
                (if (equal *indexNotVars3* NIL)
                    (push z *indexNotVars3*)
                    (push z (cdr (last *indexNotVars3*)))
                )
                (if (equal *indexVars3* NIL)
                    (push z *indexVars3*)
                    (push z (cdr (last *indexVars3*)))
                )
            )
        )

        ;(format t "~d ~%" *indexVars3*)
        ;(format t "~d ~%" *indexNotVars3*)

        (setf *all-args* (list))
        (setf *all-responses* (list))

        (setf *allflag* 1)

        (loop for x from 0 to (- (length all) 1) do
            (setf *f* 1)
            (setf *a-args* (list))
            (setf *a-responses* (list))

            (setf *a-args2* (list))
            (setf *a-responses2* (list))

            (if (and (equal *f* 1) (string= (nth 0 (nth x all)) "Fact"))
                (progn
                    (setf *copy-fact* (copy-list (nth 1 (nth x all))))
                    (setf *copy-fact-name* (nth 0 *copy-fact*))
                    (setf *copy-fact-args* (nth 1 *copy-fact*))
                    
                    (if (equal *rb-name* *copy-fact-name*)
                        (if (equal *indexNotVars3* NIL)
                            (loop for y from 0 to (- (length *copy-fact-args*) 1) do 
                                (if (equal *a-args* NIL)
                                    (push (nth y *rb-args*) *a-args*)
                                    (push (nth y *rb-args*) (cdr (last *a-args*)))
                                )
                                (if (equal *a-responses* NIL)
                                    (push (nth y *copy-fact-args*) *a-responses*)
                                    (push (nth y *copy-fact-args*) (cdr (last *a-responses*)))
                                )
                            )
                            (loop for y from 0 to (- (length *copy-fact-args*) 1) do 
                                (if (position y *indexNotVars3*)
                                    (if (equal (nth y *copy-fact-args*) (nth y *rb-args*))
                                        ;(format t "sdsd: ~d ~%" (nth y *copy-fact-args*))
                                        ()
                                        (setf *allflag* 0)
                                    )
                                )
                                (if (position y *indexVars3*)
                                    (if (equal (nth y *copy-fact-args*) (nth y *rb-args*))
                                        ()
                                        (progn
                                            (if (equal *a-args2* NIL)
                                                (push (nth y *rb-args*) *a-args2*)
                                                (push (nth y *rb-args*) (cdr (last *a-args2*)))
                                            )
                                            (if (equal *a-responses2* NIL)
                                                (push (nth y *copy-fact-args*) *a-responses2*)
                                                (push (nth y *copy-fact-args*) (cdr (last *a-responses2*)))
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )

                    (if (not (equal *a-args* NIL))
                        (if (equal *all-args* NIL)
                            (push *a-args* *all-args*)
                            (push *a-args* (cdr (last *all-args*)))
                        )
                    )
                    (if (not (equal *a-args2* NIL))
                        (if (equal *all-args* NIL)
                            (push *a-args2* *all-args*)
                            (push *a-args2* (cdr (last *all-args*)))
                        )
                    )
                    (if (not (equal *a-responses* NIL))
                        (if (equal *all-responses* NIL)
                            (push *a-responses* *all-responses*)
                            (push *a-responses* (cdr (last *all-responses*)))
                        )
                    )
                    (if (not (equal *a-responses2* NIL))
                        (if (equal *all-responses* NIL)
                            (push *a-responses2* *all-responses*)
                            (push *a-responses2* (cdr (last *all-responses*)))
                        )
                    )
                )
            )
        )
        
        (setf *flag3* 1)
        (loop for d from 0 to (- (length *all-args*) 1) do
            (setf *dall-args* (nth d *all-args*))
            (setf *dall-responses* (nth d *all-responses*))
            (if (not (equal (position NIL *dall-args*) NIL))
                (progn
                    (setf *all-args* (remove-nth-element d *all-args*))
                    (setf *all-responses* (remove-nth-element d *all-responses*))
                )
                ()
            )
            (if (not (equal (position NIL *dall-responses*) NIL))
                (progn
                    (setf *all-args* (remove-nth-element d *all-args*))
                    (setf *all-responses* (remove-nth-element d *all-responses*))
                )
                ()
            )
        )
        ;(format t "aargs: ~d ~%" *all-args*)
        ;(format t "aresponses: ~d ~%" *all-responses*)

        (loop for i from 0 to (- (length *final-args*) 1) do
            (setf *ifa* (nth i *final-args*))
            (setf *ifr* (nth i *final-responses*))

            (loop for j from 0 to (- (length *all-args*) 1) do
                (setf *jaa* (nth j *all-args*))
                (setf *jar* (nth j *all-responses*))
                
                ;(format t "jaa: ~d ~%" *jaa*)
                ;(format t "jar: ~d ~%" *jar*)  

                (loop for k from 0 to (- (length *ifa*) 1) do
                    (setf *kifa* (nth k *ifa*))
                    (setf *kifr* (nth k *ifr*))

                    ;(format t "ifa: ~d ~%" *kifa*)
                    ;(format t "ifr: ~d ~%" *kifr*)

                    (if (equal *jaa* *kifa*)
                        (if (equal *jar* *kifr*)
                            ()
                            (progn
                                ;(format t "----bbbbbbb--~%")
                                (setf *ifa* (remove-nth-element k *ifa*))
                                (setf *ifr* (remove-nth-element k *ifr*))
                                (setf k (- k 1))
                            )
                        )
                    )  
                )

                (setf (nth i *final-args*) *ifa*)
                (setf (nth i *final-responses*) *ifr*)
            )

            ;(format t "ifa: ~d ~%" *ifa*)
            ;(format t "ifr: ~d ~%" *ifr*)    
        )

        (if (equal *final-args* NIL)
            (push *all-args* *final-args*)
            (push *all-args* (cdr (last *final-args*)))
        ) 
        (if (equal *final-responses* NIL)
            (push *all-responses* *final-responses*)
            (push *all-responses* (cdr (last *final-responses*)))
        )

         
    )

    ;(format t "finalargs: ~d ~%" *final-args*)
    ;(format t "finalresponses: ~d ~%" *final-responses*)   
    
    (loop for i from 0 to (- (length *final-args*) 1) do
        (setf *ifa* (nth i *final-args*))
        (setf *ifr* (nth i *final-responses*))
            
        (loop for j from 0 to (- (length *final-args*) 1) do
            (setf *jfa* (nth j *final-args*))
            (setf *jfr* (nth j *final-responses*))
            
            ;(format t "jfa: ~d ~%" *jfa*)
            ;(format t "jfr: ~d ~%" *jfr*)

            (loop for k from 0 to (- (length *jfa*) 1) do
                (setf *kjfa* (nth k *jfa*))
                (setf *kjfr* (nth k *jfr*))
            
                (if (and (not (equal k j)) (not (equal (position *kjfa* *jfa*) j)))
                    (progn
                        (loop for m from 0 to (- (length *kjfa*) 1) do
                            (setf *mkjfa* (nth m *kjfa*))
                            (setf *mkjfr* (nth m *kjfr*))

                            (format t "~d : ~d ~%" *mkjfa* *mkjfr*)
                            (princ *mkjfa* my-stream)
                            (princ ": " my-stream)
                            (princ *mkjfr* my-stream)
                            (princ #\linefeed my-stream)
                        )
                    )
                )
            )
        )
    )

    ;; YANLIŞ Algoritma
    
)

(defun handleQuery (query all my-stream)
    (setf *gflag* 1)
    (setf *query-body* (nth 2 query))
    (setf *query-body-name* (nth 0 *query-body*))
    (setf *query-body-args* (nth 1 *query-body*))
    (setf *query-body-args-isVar* (list))

    (loop for y from 0 to (- (length *query-body-args*) 1) do
        (if (equal *query-body-args-isVar* NIL)
            (push (upper-case-p (char (nth y *query-body-args*) 0)) *query-body-args-isVar*)
            (push (upper-case-p (char (nth y *query-body-args*) 0)) (cdr (last *query-body-args-isVar*)))
        )
    )

    ;(format t "~d ~%" *query-body-args-isVar*)
    (format t "Query: ~d ~%" (nth 2 query))
    (princ "Query: " my-stream)
    (princ (nth 2 query) my-stream)
    (princ #\linefeed my-stream)
    
    (loop for x from 0 to (- (length all) 1) do
        ;(format t "~d ~%" (nth x all))
        (setf *f* 1)
        (if (not (equal (nth x all) NIL))
            (progn 
                (if (and (equal *f* 1) (string= (nth 0 (nth x all)) "Fact"))
                    (progn
                        (setf *f* 0)
                        (setf *flag* 1)
                        (if (and (equal *flag* 1) (equal (nth 1 (nth x all)) *query-body*))
                            (progn
                                (setf *flag* 0)
                                (format t "Query is true~%")
                                (princ "Query is true" my-stream)
                                (princ #\linefeed my-stream)
                            )
                        )
                        (setf *varPos* (position T *query-body-args-isVar*))
                        (setf *indexVars* (list))
                        (loop for z from 0 to (- (length *query-body-args-isVar*) 1) do
                            (if (equal (nth z *query-body-args-isVar*) NIL)
                                ()
                                (if (equal *indexVars* NIL)
                                    (push z *indexVars*)
                                    (push z (cdr (last *indexVars*)))
                                )
                            )
                        )
                        (if (and (equal *flag* 1) (equal (nth 0 (nth 1 (nth x all))) *query-body-name*) *varPos*)
                            (progn
                                (setf *flag* 0)
                                (setf *statement* 1)
                                (loop for y from 0 to (- (length *query-body-args*) 1) do 
                                    ;(format t "~d ~%" *statement*)
                                    (if (and (equal (nth y *query-body-args-isVar*) NIL) (equal (nth y *query-body-args*) (nth y (nth 1 (nth 1 (nth x all))))))
                                        (progn
                                            ;(format t "~d ~%" (nth y *query-body-args*))
                                        )
                                        (if (equal (nth y *query-body-args-isVar*) NIL)
                                            (setf *statement* 0)
                                        )
                                    )
                                )
                                (if (equal *statement* 1)
                                    (loop for z from 0 to (- (length *indexVars*) 1) do
                                        (format t "~d: ~d ~%" (nth z *query-body-args*) (nth z (nth 1 (nth 1 (nth x all)))))
                                        (princ (nth z *query-body-args*) my-stream)
                                        (princ ": " my-stream)
                                        (princ (nth z (nth 1 (nth 1 (nth x all)))) my-stream)
                                        (princ #\linefeed my-stream)
                                    )
                                )
                            )
                        )
                    )
                    ()
                )
                (if (and (equal *f* 1) (string= (nth 0 (nth x all)) "Rule"))
                    (progn
                        (setf *f* 0)
                        (setf *rule-body* (nth 2 (nth x all)))
                        (setf *query-indexVars* (list))
                        (loop for z from 0 to (- (length *query-body-args-isVar*) 1) do
                            (if (equal (nth z *query-body-args-isVar*) NIL)
                                ()
                                (if (equal *query-indexVars* NIL)
                                    (push z *query-indexVars*)
                                    (push z (cdr (last *query-indexVars*)))
                                )
                            )
                        )

                        ;(format t "~d ~%" *query-indexVars*)

                        (setf *rule-head-args-isVar* (list))
                        (setf *rule-head-args* (nth 1 (nth 1 (nth x all))))
                        (loop for y from 0 to (- (length *rule-head-args*) 1) do
                            (if (equal *rule-head-args-isVar* NIL)
                                (push (upper-case-p (char (nth y *rule-head-args*) 0)) *rule-head-args-isVar*)
                                (push (upper-case-p (char (nth y *rule-head-args*) 0)) (cdr (last *rule-head-args-isVar*)))
                            )
                        )

                        ;(format t "~d ~%" *rule-head-args-isVar*)

                        (if (equal *query-body-name* (nth 0 (nth 1 (nth x all))))
                            ;(format t "~d ~%" *rule-head-args*)
                            ()
                        )

                        (setf *rha* (list))
                        (setf *qba* (list))

                        (setf *rha2* (list))
                        (setf *qba2* (list))

                        ;(format t "~d ~%" *query-indexVars*)
                        ;(format t "~d ~d ~%" *rule-head-args* *query-body-args*)
                        
                        (setf *statement* 1)
                        (setf *vv* 0)
                        (setf *vv2* 1)

                        (if (equal *query-body-name* (nth 0 (nth 1 (nth x all))))
                            (progn
                                (if (equal *query-indexVars* NIL)
                                    (progn
                                        (loop for z from 0 to (- (length *rule-head-args*) 1) do
                                            (if (upper-case-p (char (nth z *rule-head-args*) 0))
                                                (progn
                                                    (if (equal *rha* NIL)
                                                        (push (nth z *rule-head-args*) *rha*)
                                                        (push (nth z *rule-head-args*) (cdr (last *rha*)))             
                                                    )
                                                    (if (equal *qba* NIL)
                                                        (push (nth z *query-body-args*) *qba*)
                                                        (push (nth z *query-body-args*) (cdr (last *qba*)))             
                                                    )
                                                )
                                                (if (equal (nth z *rule-head-args*) (nth z *query-body-args*))
                                                    ;(format t "~d ~%" (nth z *rule-head-args*))
                                                    ()
                                                    (setf *statement* 0)
                                                )
                                            )
                                        )
                                        (if (equal *statement* 1)
                                            ;(format t "~d ~d ~d ~%" *rha* *qba* *rule-body*)
                                            (progn
                                                (setf *gflag* 0)
                                                (handleResolution *rha* *qba* *rule-body* all my-stream)
                                            )
                                            ;(format t "ssss~%")
                                        )
                                    )
                                    (loop for z from 0 to (- (length *rule-head-args*) 1) do
                                        (setf *variableList* (list))

                                        (if (equal z (nth z *query-indexVars*))
                                            (progn
                                                (setf *vv* 1)
                                                (if (equal *rha2* NIL)
                                                    (push (nth z *rule-head-args*) *rha2*)
                                                    (push (nth z *rule-head-args*) (cdr (last *rha2*)))             
                                                )
                                                (if (equal *qba2* NIL)
                                                    (push (nth z *query-body-args*) *qba2*)
                                                    (push (nth z *query-body-args*) (cdr (last *qba2*)))             
                                                )
                                            )
                                            (if (equal (nth z *rule-head-args*) (nth z *query-body-args*))
                                                ()
                                                (progn
                                                    (setf *vv2* 0)
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                        ;(format t "~d ~%" *rule-body*)

                        (setf *copy-rule-body* (mapcar #'copy-list *rule-body*))
                        ;(format t "~d ~%" *copy-rule-body*)
                        ;(setf *copy-rule-body* (copy-list *rule-body*))
                        ;(format t "st: ~d ~%" *statement*)
                        (if (and (equal *gflag* 1) (equal *vv2* 1) (equal *vv* 1))
                            (progn
                                (loop for x from 0 to (- (length *copy-rule-body*) 1) do
                                    (setf *copy-args* (copy-list (copy-list (nth 1 (copy-list (nth x *copy-rule-body*))))))
                                    ;(format t "~d ~%" *copy-args*)
                                    (loop for y from 0 to (- (length *copy-args*) 1) do
                                        (loop for z from 0 to (- (length *rha2*) 1) do
                                            (if (equal (nth y *copy-args*) (nth z *rha2*))
                                                (setf (nth y *copy-args*) (nth z *qba2*))
                                            )
                                        )
                                    )
                                    (setf (nth 1 (nth x *copy-rule-body*)) *copy-args*)
                                )
                                ;(format t "~d ~%" *copy-rule-body*)
                                (handleResolution2 *copy-rule-body* all my-stream)
                                ;(format t "~d ~%" *rha2*)
                                ;(format t "~d ~%" *qba2*)
                            )
                        )
                        
                    )
                )   
            )
        )
    )
)

(with-open-file (my-stream 
        "output.txt"
        :direction :output
        :if-does-not-exist :create
        :if-exists :supersede)

    (if (equal (open 'input.txt' :if-does-not-exist nil) NIL)
        (progn
            (format t "~d ~%" "Error: 'input.txt' is not found.")
            (princ "Error: 'input.txt' is not found." my-stream)
        )
        (let ((in (open 'input.txt' :if-does-not-exist nil)))
            (when in
                (setf *all* (list))
                (setf *types* (list))
                (loop for line = (read-line in nil)
                    while line 
                        do
                        (setf *ln* (handleLine line my-stream))
                        (if (equal *all* NIL)
                            (progn
                                (push *ln* *all*)
                            )
                            (progn
                                (push *ln* (cdr (last *all*)))
                            )
                        )
                )
                (close in)
                (remove-if #'null *all*)
                (loop for x from 0 to (- (length *all*) 1) do
                    ;(format t "~d ~%" (nth x *all*))

                    (if (not (equal (nth x *all*) NIL))
                        (if (string= (nth 0 (nth x *all*)) "Query")
                            (progn
                                (handleQuery (nth x *all*) *all* my-stream)
                            )
                            ()
                        )
                    )
                )
            )
        )
    )
)