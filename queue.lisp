(provide :queue)
(defpackage :queue (:use :cl))
(in-package :queue)
(export '(make-queue emptyp enqueue dequeue))

(defstruct queue (front) (rear))

(defun emptyp (q)
  (null (queue-front q)))

(defun enqueue (q item)
  (let ((new-cell (list item)))
    (if (emptyp q)
        (setf (queue-front q) new-cell)
        (setf (cdr (queue-rear q)) new-cell))
    (setf (queue-rear q) new-cell))
  item)

(defun dequeue (q)
  (unless (emptyp q)
    (prog1
        (pop (queue-front q))
      (when (emptyp q)
        (setf (queue-rear q) nil)))))
