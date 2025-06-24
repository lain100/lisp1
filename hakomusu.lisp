(defun move-l1-up (board x w h)
  (declare (ignore h))
  (let ((x1 (- x w)))
    (if (and (<= 0 x1)
             (eq (aref board x1)      'S)
             (eq (aref board (1+ x1)) 'S))
        (let ((new-board (copy-seq board)))
          (setf (aref new-board x1)       'L1
                (aref new-board (1+ x1))  'L2
                (aref new-board x)        'L2
                (aref new-board (1+ x))   'L2
                (aref new-board (+ x w))   'S
                (aref new-board (+ x w 1)) 'S)
          (values new-board x1)))))

(defun move-l1-down (board x w h)
  (let ((x1 (+ x w w)))
    (if (and (< (1+ x1) (* w h))
             (eq (aref board x1)      'S)
             (eq (aref board (1+ x1)) 'S))
       (let ((new-board (copy-seq board)))
         (setf (aref new-board x1)        'L2
               (aref new-board (1+ x1))   'L2
               (aref new-board (+ x w))   'L1
               (aref new-board (+ x w 1)) 'L2
               (aref new-board x)         'S
               (aref new-board (1+ x))    'S)
         (values new-board (+ x w))))))

(defun move-l1-left (board x w h)
  (declare (ignore h))
  (let ((x1 (1- x)))
    (if (and (/= (mod x1 w) (1- w))
             (eq (aref board x1)       'S)
             (eq (aref board (+ x1 w)) 'S))
       (let ((new-board (copy-seq board)))
         (setf (aref new-board x1)        'L1
               (aref new-board (+ x1 w))  'L2
               (aref new-board x)         'L2
               (aref new-board (+ x w))   'L2
               (aref new-board (1+ x))    'S
               (aref new-board (+ x w 1)) 'S)
         (values new-board x1)))))

(defun move-l1-right (board x w h)
  (declare (ignore h))
  (let ((x1 (+ x 2)))
    (if (and (/= (mod x1 w) 0)
             (eq (aref board x1)       'S)
             (eq (aref board (+ x1 w)) 'S))
       (let ((new-board (copy-seq board)))
         (setf (aref new-board x1)        'L2
               (aref new-board (+ x1 w))  'L2
               (aref new-board (1+ x))    'L1
               (aref new-board (+ x w 1)) 'L2
               (aref new-board x)         'S 
               (aref new-board (+ x w))   'S)
         (values new-board (1+ x))))))

(defun move-m1-up (board x w h)
  (declare (ignore h))
  (let ((x1 (- x w)))
    (if (and (<= 0 x1)
             (eq (aref board x1) 'S))
        (let ((new-board (copy-seq board)))
          (setf (aref new-board x1)      'M1
                (aref new-board x)       'M2
                (aref new-board (+ x w)) 'S)
          (values new-board x1)))))

(defun move-m1-down (board x w h)
  (let ((x1 (+ x w w)))
    (if (and (< x1 (* w h))
             (eq (aref board x1) 'S))
        (let ((new-board (copy-seq board)))
          (setf (aref new-board x1)      'M2
                (aref new-board (+ x w)) 'M1
                (aref new-board x)       'S)
          (values new-board (+ x w))))))

(defun move-m1-left (board x w h)
  (declare (ignore h))
  (let ((x1 (1- x)))
    (if (and (/= (mod x1 w) (1- w))
             (eq (aref board x1) 'S)
             (eq (aref board (+ x1 w)) 'S))
        (let ((new-board (copy-seq board)))
          (setf (aref new-board x1)       'M1
                (aref new-board (+ x1 w)) 'M2
                (aref new-board x)        'S
                (aref new-board (+ x w))  'S)
          (values new-board x1)))))

(defun move-m1-right (board x w h)
  (declare (ignore h))
  (let ((x1 (1+ x)))
    (if (and (/= (mod x1 w) 0)
             (eq (aref board x1) 'S)
             (eq (aref board (+ x1 w)) 'S))
        (let ((new-board (copy-seq board)))
          (setf (aref new-board x1)       'M1
                (aref new-board (+ x1 w)) 'M2
                (aref new-board x)        'S
                (aref new-board (+ x w))  'S)
          (values new-board x1)))))

(defun move-n1-up (board x w h)
  (declare (ignore h))
  (let ((x1 (- x w)))
    (if (and (<= 0 x1)
             (eq (aref board x1) 'S)
             (eq (aref board (1+ x1)) 'S))
        (let ((new-board (copy-seq board)))
          (setf (aref new-board x1)      'N1
                (aref new-board (1+ x1)) 'N2
                (aref new-board x)        'S
                (aref new-board (1+ x))   'S)
          (values new-board x1)))))

(defun move-n1-down (board x w h)
  (let ((x1 (+ x w)))
      (if (and (< (1+ x1) (* w h))
               (eq (aref board x1) 'S)
               (eq (aref board (1+ x1)) 'S))
          (let ((new-board (copy-seq board)))
            (setf (aref new-board x1)      'N1
                  (aref new-board (1+ x1)) 'N2
                  (aref new-board x)        'S
                  (aref new-board (1+ x))   'S)
            (values new-board x1)))))

(defun move-n1-left (board x w h)
  (declare (ignore h))
  (let ((x1 (- x 1)))
    (if (and (/= (mod x1 w) (1- w))
             (eq (aref board x1) 'S))
        (let ((new-board (copy-seq board)))
          (setf (aref new-board x1)      'N1
                (aref new-board (1+ x1)) 'N2
                (aref new-board (1+ x))   'S)
          (values new-board x1)))))

(defun move-n1-right (board x w h)
  (declare (ignore h))
  (let ((x1 (+ x 2)))
    (if (and (/= (mod x1 w) 0)
             (eq (aref board x1) 'S))
        (let ((new-board (copy-seq board)))
          (setf (aref new-board x1)     'N2
                (aref new-board (1+ x)) 'N1
                (aref new-board x)       'S)
          (values new-board (1+ x))))))

(defun move-o-up (board x w h)
  (declare (ignore h))
  (let ((x1 (- x w)))
    (if (and (<= 0 x1)
             (eq (aref board x1) 'S))
        (let ((new-board (copy-seq board)))
          (setf (aref new-board x1) 'O
                (aref new-board x)  'S)
          (values new-board x1)))))

(defun move-o-down (board x w h)
  (let ((x1 (+ x w)))
    (if (and (< x1 (* w h))
             (eq (aref board x1) 'S))
        (let ((new-board (copy-seq board)))
          (setf (aref new-board x1) 'O
                (aref new-board x)  'S)
          (values new-board x1)))))

(defun move-o-left (board x w h)
  (declare (ignore h))
  (let ((x1 (1- x)))
    (if (and (/= (mod x1 w) (1- w))
             (eq (aref board x1) 'S))
        (let ((new-board (copy-seq board)))
          (setf (aref new-board x1) 'O
                (aref new-board x)  'S)
          (values new-board x1)))))

(defun move-o-right (board x w h)
  (declare (ignore h))
  (let ((x1 (1+ x)))
    (if (and (/= (mod x1 w) 0)
             (eq (aref board x1) 'S))
        (let ((new-board (copy-seq board)))
          (setf (aref new-board x1) 'O
                (aref new-board x)  'S)
          (values new-board x1)))))

(defun move-p1-up (board x w h)
  (declare (ignore h))
  (let ((x1 (- x w)))
    (if (and (<= 0 x1)
             (eq (aref board x1)       'S)
             (eq (aref board (1+ x1))  'S)
             (eq (aref board (+ x1 2)) 'S)
             (eq (aref board (+ x1 3)) 'S))
        (let ((new-board (copy-seq board)))
          (setf (aref new-board x1)       'P1
                (aref new-board (1+ x1))  'P2
                (aref new-board (+ x1 2)) 'P2
                (aref new-board (+ x1 3)) 'P2
                (aref new-board x)        'S
                (aref new-board (1+ x))   'S
                (aref new-board (+ x 2))  'S
                (aref new-board (+ x 3))  'S)
          (values new-board x1)))))

(defun move-p1-down (board x w h)
  (let ((x1 (+ x w)))
    (if (and (< (+ x1 3) (* w h))
             (eq (aref board x1)       'S)
             (eq (aref board (1+ x1))  'S)
             (eq (aref board (+ x1 2)) 'S)
             (eq (aref board (+ x1 3)) 'S))
        (let ((new-board (copy-seq board)))
          (setf (aref new-board x1)       'P1
                (aref new-board (1+ x1))  'P2
                (aref new-board (+ x1 2)) 'P2
                (aref new-board (+ x1 3)) 'P2
                (aref new-board x)        'S
                (aref new-board (1+ x))   'S
                (aref new-board (+ x 2))  'S
                (aref new-board (+ x 3))  'S)
          (values new-board x1)))))

(defun move-p1-left (board x w h)
  (declare (ignore h))
  (let ((x1 (1- x)))
    (if (and (/= (mod x1 w) (1- w))
             (eq (aref board x1) 'S))
        (let ((new-board (copy-seq board)))
          (setf (aref new-board x1)      'P1
                (aref new-board x)       'P2
                (aref new-board (1+ x))  'P2
                (aref new-board (+ x 2)) 'P2
                (aref new-board (+ x 3)) 'S)
          (values new-board x1)))))

(defun move-p1-right (board x w h)
  (declare (ignore h))
  (let ((x1 (+ x 4)))
    (if (and (/= (mod x1 w) 0)
             (eq (aref board x1) 'S))
        (let ((new-board (copy-seq board)))
          (setf (aref new-board x1)      'P2
                (aref new-board (1+ x))  'P1
                (aref new-board (+ x 2)) 'P2
                (aref new-board (+ x 3)) 'P2
                (aref new-board x)       'S)
          (values new-board (1+ x))))))

(move-p1-right (make-array 30 :INITIAL-ELEMENT 'S) 0 6 5)

(require :queue "queue.lisp")
(use-package :queue)

(defvar *queue* (make-queue))
(defvar *table* (make-hash-table :test 'equalp))

(defvar *move-list*
  `((L1 ,#'move-l1-up ,#'move-l1-down ,#'move-l1-left ,#'move-l1-right)
    (M1 ,#'move-m1-up ,#'move-m1-down ,#'move-m1-left ,#'move-m1-right)
    (N1 ,#'move-n1-up ,#'move-n1-down ,#'move-n1-left ,#'move-n1-right)
    (O  ,#'move-o-up  ,#'move-o-down  ,#'move-o-left  ,#'move-o-right)
    (P1 ,#'move-p1-up ,#'move-p1-down ,#'move-p1-left ,#'move-p1-right)))

(defun solve (start goalp &optional (w 4) (h 5))
  (enqueue *QUEUE* (list start 0 nil))
  (setf (gethash start *TABLE*) t)
  (loop until (queue-emptyp *QUEUE*)
        as state = (dequeue *QUEUE*)
        when (funcall goalp (car state))
        return (apply #'print-answer w h state)
        do (loop as x from 0 below (* w h)
                 do (move-piece (car state)
                                x
                                w
                                h
                                (cdr (assoc (aref (car state) x) *move-list*))
                                state
                                t))))

(defun move-piece (board x w h move state flag)
  (loop as fn in move
        do (multiple-value-bind
               (new-board x1)
               (funcall fn board x w h)
             (when new-board
               (unless (gethash new-board *TABLE*)
                 (setf (gethash new-board *TABLE*) t)
                 (enqueue *QUEUE* (list new-board (1+ (second state)) state)))
               (when flag
                 (move-piece new-board x1 w h move state nil)))))) 

(defun print-board (board &optional (w 4) (h 5))
  (loop as x from 0 below (* w h) do (format t "~2a " (aref board x))
        if (= (mod x w) (1- w)) do (terpri))
  (terpri))

(print-board (make-array 30) 6 5)

(defun print-answer (w h board n prev)
  (if (consp prev) (apply #'print-answer w h prev))
  (format t "~d:~%" n)
  (print-board board w h))

(defvar *q01*
  #(M1 L1 L2 M1
    M2 L2 L2 M2
    M1 N1 N2 M1
    M2 O  O  M2
    O  S  S  O))

(defvar *q02*
  #(M1 L1 L2 M1
    M2 L2 L2 M2
    O  N1 N2 O
    N1 N2 N1 N2
    O  S  S  O))

(defvar *q03*
  #(L1 L2 N1 N2
    L2 L2 N1 N2
    O  O  S  S
    M1 M1 N1 N2
    M2 M2 N1 N2))

(defvar *q04*
  #(S  S  M1 L1 L2 M1
    S  S  M2 L2 L2 M2
    O  s s s s  O
    O  s s s s O
    O  N1 N2 N1 N2 O))

(queue-clear *queue*)
(clrhash *TABLE*)

(solve *Q04* (lambda (x) (eq (aref x 20) 'L1)) 6 5)
(solve *Q01* (lambda (x) (eq (aref x 13) 'L1)))
