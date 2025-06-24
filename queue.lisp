(provide :queue)
(defpackage :queue (:use :cl))
(in-package :queue)
(export '(make-queue enqueue dequeue queue-emptyp queue-clear))

(defstruct queue (front nil) (rear nil))

(defun enqueue (q item)
  (let ((new-cell (list item)))
    (if (queue-front q)
        (setf (cdr (queue-rear q)) new-cell)
        (setf (queue-front q) new-cell))
    (setf (queue-rear q) new-cell)))

(defun dequeue (q)
  (when (queue-front q)
    (prog1 (pop (queue-front q))
      (unless (queue-front q)
          (setf (queue-rear q) nil)))))

(defun queue-emptyp (q)
 (null (queue-front q)))

(defun queue-clear (q)
  (setf (queue-front q) nil
        (queue-rear q) nil))
