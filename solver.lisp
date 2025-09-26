(defun show-board (board)
  (loop as i from 0 below (length board)
        do (format t "~a " (aref board i))
        when (zerop (mod (1+ i) 4))
        do (terpri)
        finally (terpri)))

(defun check-board (board)
  (loop as i from 0 below (length board)
        as piece = (aref board i)
        when (and (numberp piece)
                  (/= piece 
                      (loop as pos in (make-around i)
                            count (eq 'x (aref board pos)))))
        return nil
        finally (return t)))

(defun comb (xs r)
  (cond
    ((zerop r) '(()))
    ((null xs) nil)
    (t
     (append
       (mapcar (lambda (ys) (cons (car xs) ys))
               (comb (cdr xs) (1- r)))
       (comb (cdr xs) r)))))

(defun make-around (index)
  (loop as dy from -1 to 1
        append (loop as dx from -1 to 1
                     as pos = (+ (* dy 4) dx index)
                     when (and (not (= dx dy 0))
                               (<= 0 pos 15)
                               (not (and (zerop (mod index 4))
                                         (= dx -1)))
                               (not (and (zerop (mod (1+ index) 4))
                                         (= dx 1))))
                     collect pos)))

(defun make-choices (board index)
  (comb (make-around index) (aref board index)))

(defun solver ()
  (clrhash *table*)
  (dolist (x '(1 3))
    (loop as y in '(1 3)
          as board = (make-array 16 :INITIAL-ELEMENT #\space)
          do (setf (aref board 1) x
                   (aref board 7) 1
                   (aref board 8) y
                   (aref board 14) 4)
          (solver-body board))))

(defvar *table* (make-hash-table :test #'equalp))

(defun solver-body (board &optional (init 0))
  (loop as i from init below (length board)
        as piece = (aref board i)
        as choices = (and (numberp piece) (make-choices board i))
        do (loop as choice in choices
                 as new-board = (copy-seq board)
                 do (dolist (pos choice)
                      (setf (aref new-board pos) 'x))
                 (solver-body new-board (1+ i)))
        finally (when (and (not (gethash board *table*))
                           (check-board board))
                  (show-board board)
                  (setf (gethash board *table*) t))))

(solver)
