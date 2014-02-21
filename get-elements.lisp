;;;; get-elements.lisp

(defpackage #:get-elements
  (:use #:cl)
  (:export #:by-path
	   #:by-tag-name))

(in-package #:get-elements)

;;; "get-elements" goes here. Hacks and glory await!

(defun by-path (tree path &key (test #'equal) (relative-path t))
  "Find all lists in s-expression (tree) which can be accesed through path (relative or absolute)"
  (let ((result nil))
    (when (and path (listp path))
      (let ((elements (by-tag-name tree (car path) :test test :recursive relative-path)))
	(when (= (length path) 1)
	  (setf result (append result elements)))
	(loop for element in elements do
	     (setf result (append result (by-path (cdr element) (cdr path) :test test))))))
    result))
	  
	


(defun by-tag-name (tree tag-name &key (recursive t) (test #'equal))
  "Find all lists in s-expression (tree) which are starting with tag-name and return them in a list."
  (let ((result nil))
    (if (listp tree)
	;; loop over elements in top-level of tree
	(loop for element in tree do
	     (when (listp element)
	       ;; if list (tree) contains at least one list and the car of this list is equal to tag-name then append to result
	       (when (funcall test tag-name (car element))
		 (setf result (append result (list element))))
	       ;; optional recursive digging
	       (when recursive
		 (setf result (append result (by-tag-name element tag-name :test test)))))))
    result))






;; EOF
;(com.informatimago.common-lisp.html-parser.parse-html:parse-html-string)
  


