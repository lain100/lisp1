(defvar *adjacent* #((5 7) (6 8) (3 7)
                     (2 8 10) (9 11) (0 6 10)
                     (1 5 11) (0 2) (1 3 9)
                     (4 8) (3 5) (4 6))) 

(defun solver (&optional (path '(0)))
  (if (= (length path) (length *adjacent*))
      (show-answer (reverse path))
      (loop as address in (aref *adjacent* (car path))
            unless (member address path)
            do (solver (cons address path)))))

(defun show-answer (path &optional (w 3) (h 4))
  (loop repeat h
        as board = (loop with board = (make-array (* w h))
                         as count from 0
                         as move in path
                         do (setf (aref board move) count)
                         finally (return (coerce board 'list)))
        then (nthcdr w board)
        do (format t "~?" (format nil "|~~~a@{~~~ad|~~}~~%" w 2) board)
        finally (terpri)))


(loop as x in '(0 1 3 4) do (solver (list x)))
