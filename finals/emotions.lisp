#| File is: Emontions.LISP  Anirudh Edupuganti version 1.0  06-08-2021

I have made alterations using the code Animal.LISP  by Clark Elliot Version 7.2

I have writen three functions:
   A. (make-happy-personality)
   B. (make-normal-personality)
   C. (make-Stressed-personality)

;;;-----------------------------------------------------------------

More advanced:

For the more advanced version of the Emotions program, the more times the program gets wrong
answers, the more intense its emotions get. The more times the program gets right answers, the
less intense its emotions get.

So developed a model of the intensity of its responses that works with any one of the
personalities. 

;;;-----------------------------------------------------------------

;;;-----------------------------------------------------------------

Here is what a saved data file a.lisp looks like (indentation added):

(setq
 *nodes*
 '(
   (3 "Are you having headaches" yes No)
   (2 "How is the culture here" good bad)
   (Feeling "Are you stressed" (2) (3))
   ))
(setq *node-count* 3)

;;;-----------------------------------------------------------------


Be sure to make periodic backups of your work:

> Copy EmotionsB.lisp save-Emotions-B.lisp

And keep versions:

> Copy EmotionsB.lisp EmotionsC.lisp


To the code run this in Armed Bear Common LISP that runs under java:

> java -jar abcl-0.15.0.jar
> (load "Emotions.lisp")

> (load "emotions") <-- this shorthand will also work.

This program tries to guess what animal you are thinking of by
asking questions. If it guesses wrong, it will learn the correct answer
for next time. It uses a dynamically constructed binary search tree.

To save a session, after answering "n" to "Do you want to play again?,"
type (saveit "filename.lisp") where filename is the name of the file into
which you wish to save your data (e.g., (saveit "a.lisp") (saveit "b.lisp").

WARNING!! Be sure you don't save your data file on top of your LISP program:

No, no, no! ==> (saveit "emotions.lisp") NO, NO!

To load your data back in, type (load "filename.lisp") where filename is the
name of the file in which your data resides

If you have much data (many emotions) save copies of your data file (which might get corrupted):

> Copy b.lisp save-b.lisp

Run the program, play with it, then make the modifications specified in the assignment.

Add your extensive COMMENTS about what the program is doing in each section of the code.

|#
(format t "~%This is Anirudh Edupuganti's emotions Learning program~%")

;;; ABOVE IS WHERE YOU ADD CODE TO PRINT YOUR NAME USING THE FORMAT COMMAND.

(defun emotions () 
  (loop
   (run-node 'feeling)
    (when (not (ask-play-again)) 
      (format t "Thanks for playing. [Use (saveit \"fname.lisp\") if you want to save your data.]~%")
      (return))))

;;; =============================================================
;;; ======   This is the section we will modify:   ==============
;;; =============================================================
;;;if we call a happy win resopnse the below responses comes 
(setq *happy-win-responses*
      (list "I thought so"
            "all will be good!"))
;;;if we call a normal win resopnse the below responses comes 
(setq *normal-win-responses*
      (list "LOL easy."
      ""
            "Can't beat me"))
;;;if we call a stressed win resopnse the below responses comes 
(setq *stressed-win-responses*
      (list "take care"
      "Try some thing new pal"
            "Go on a holiday"))

(defun gloat ()
  (let ((i (random (length *win-responses*))))
    (format t "~A~%" (nth i *win-responses*))))

;;;if we call a happy lose resopnse the below responses comes 
(setq *happy-lose-responses*
      (list "Ahh "
       "I thought I knew "
       "I will see you again"))

;;;if we call a normal lose resopnse the below responses comes 
(setq *normal-lose-responses*
      (list "Next time buddy"
       "Man, I got you"
       "DARN, will get you soon"))

;;;if we call a stressed loose resopnse the below responses comes 
(setq *stressed-lose-responses*
      (list "Can't imagine"
       "Take a leave"
       "GOD. Take care"))

(defun i-lost ()
  (let ((i (random (length *lose-responses*))))
    (format t "~A~%" (nth i *lose-responses*))))

;;; Below are the three functions that we need

(defun make-happy-personality () (setq *win-responses* *happy-win-responses*)
(setq *lose-responses* *happy-lose-responses*))

(defun make-normal-personality ()(setq *win-responses* *normal-win-responses*)
(setq *lose-responses* *normal-lose-responses*))

(defun make-stressed-personality ()(setq *win-responses* *stressed-win-responses*)
(setq *lose-responses* *stressed-lose-responses*))



;;; =============================================================
;;; ======+++   End of what we will modify  =====================
;;; =============================================================


(defun saveit (filename)
  (if (stringp filename)
      (let ((saver (open filename :direction :output 
			 :if-exists :supersede)))
	(format saver "(setq *nodes* ~%'")
	(pprint *nodes* saver) ; Saves our data of animals to a file.
	;(format saver "~%(setq *nodes* '~s)" *nodes*)
	(format saver ")~%(setq *node-count* ~s)" *node-count*)
        (close saver)) ; note SHOULD use with-open-file, not in XLISP
      (format t "Sorry, filename must be a string~%")))

(defvar *nodes*) (setq *nodes* nil)
(defvar *node-count*) (setq *node-count* 1)
(defun node-count () (incf *node-count*))

(defun node-name (n)       (first n))
(defun node-question (n)   (second n))
(defun node-yes-branch (n) (third n))
(defun node-no-branch (n)  (fourth n))

(defun defnode (name question yes-branch no-branch)
  (setq *nodes* 
	(cons (list name question yes-branch no-branch) *nodes*)))

(defnode 'feeling "Are you stressed" 'true 'false)
;(defnode 'feeling "How do you feel" 'good 'bad)
;(defnode 'feelling "How many hours you work?" '8hrs 'more)

;i tried the above two but i am not sure they are comming out good.

(defun get-node (name)  (assoc name *nodes*))

(defun run-node (name)
  (let ((n (get-node name)) (response nil))
    (if (equal (ask (node-question n)) 'y)

	(if (symbolp (node-yes-branch n))
	    (if (guess (node-yes-branch n))
		(gloat)
	        (setf (rest n)
		      (list (second n) (add-node (node-yes-branch n))
			    (fourth n)))) ; hack around xlisp shortcomming.
	    (run-node (first (node-yes-branch n))))

	(if (symbolp (node-no-branch n))
	    (if (guess (node-no-branch n))
		(gloat)
	        (setf (rest n)
		      (list (second n) (third n)
			    (add-node (node-no-branch n)))))
	    (run-node (first (node-no-branch n)))))))

(defun ask (question) 
  (format t "~a? [y/n]~%" question)
  (read))

(defun add-node (answer-tried)
  (let ((new-feeling nil) (new-node-name (node-count)) (new-node nil))
    (i-lost)
    (format t "~%What was it [type one word]?~%")
    (setq new-feeling (read))
    (format t 
	    "Type a question that is true for ~s and false for ~s [in quotes]:~%~%"
	    new-feeling answer-tried)
    (defnode new-node-name (read) new-feeling answer-tried) ; read-line problem
    (list new-node-name)))

(defun ask-play-again ()
  (format t "~%Would you like to answer again? [y/n]~%")
  (equal (read) 'y))

(defun guess (name)
  (format t "Is it a ~s? [y/n]~%" name)
  (equal (read) 'y))

(format t "Choose your emotional status that suits with.(make-happy-personality) (make-normal-personality) (make-stressed-personality).~%~%")
(format t "To tell your emotions, just type (emotions) at the LISP prompt~%~%")
(format t "type (load \"MyData.lisp\") at the LISP prompt.~%~%")
(format t "~%To read in previous data [in MyData.lisp], ")

