# Content_theory
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


The above code has intese comments so that one can undersnad how to run it.




