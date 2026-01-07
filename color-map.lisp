(defconstant neighbors
  #((1 2 3 5 10 11)
    (0 3 4 8 11)
    (0 3 5 6)
    (0 1 2 4 6 7)
    (1 3 7 8)
    (0 2 6 9 10)
    (2 3 5 7 9)
    (3 4 6 8 9)
    (1 4 7 9 11)
    (5 6 7 8 10 11)
    (0 5 9 11)
    (0 1 8 9 10)))

(defun color-map-sub (color n board)
  (if (= (length board) n)
      (print board)
      (loop as c from 1 to color
            when (loop as p in (aref neighbors n) always (/= c (aref board p)))
            do (setf (aref board n) c)
            (color-map-sub color (1+ n) board)
            (setf (aref board n) 0))))

(defun color-map (color)
  (let ((board (make-array (length neighbors) :INITIAL-ELEMENT 0)))
    (setf (aref board 0) 1)
    (color-map-sub color 1 board)))

(time (color-map 4))
