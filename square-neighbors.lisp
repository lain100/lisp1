(defun make-squares (n &optional (m 2))
  (if (<= (* m m) n)
      (cons (* m m) (make-squares n (1+ m)))))

(defun make-neighbors (n)
  (loop with table = (make-array (1+ n) :INITIAL-ELEMENT nil)
        with squares = (make-squares (+ n (1- n)))
        as i from 1 to n
        do (setf (aref table i)
                 (remove-if-not (lambda (x) (and (/= x i) (<= 1 x n)))
                                (mapcar (lambda (j) (- j i)) squares)))
        finally (return table)))

(defun dfs (fn board &optional (n 1))
  (if (= n (length board))
      (funcall fn board)
      (loop as p in (aref *neighbors* (aref board (1- n)))
            do (unless (find p board :end n)
                 (setf (aref board n) p)
                 (dfs fn board (1+ n))
                 (setf (aref board n) 0)))))

(defun dfs-ring (fn board &optional (n 1))
  (if (and (= n (length board))
           (member (aref board (1- n)) (aref *neighbors* (aref board 0))))
      (funcall fn board)
      (loop as p in (aref *neighbors* (aref board (1- n)))
            do (unless (find p board :end n)
                 (setf (aref board n) p)
                 (dfs-ring fn board (1+ n))
                 (setf (aref board n) 0)))))

(defun solver (&optional (fn #'dfs))
  (loop as n from 15 to 40
        as board = (make-array n :INITIAL-ELEMENT 0)
        do (format t "----- ~d -----~%" n)
        (setq *neighbors* (make-neighbors n))
        (loop as i from 1 to n
              do (setf (aref board 0) i)
              (funcall fn (lambda (x) (print x) (return-from solver)) board))))

(solver #'dfs-ring)
