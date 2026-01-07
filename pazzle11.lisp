(defconstant adjacent
  #((1 4)
    (0 2 5)
    (1 3 6)
    (2 7)
    (0 5 8)
    (1 4 6 9)
    (2 5 7 10)
    (3 6 11)
    (4 9)
    (5 8 10)
    (6 9 11)
    (7 10)))

(defconstant distance
  #2A ((0 0 0 0 0 0 0 0 0 0 0 0)
       (0 1 2 3 1 2 3 4 2 3 4 5)
       (1 0 1 2 2 1 2 3 3 2 3 4)
       (2 1 0 1 3 2 1 2 4 3 2 3)
       (3 2 1 0 4 3 2 1 5 4 3 2)
       (1 2 3 4 0 1 2 3 1 2 3 4)
       (2 1 2 3 1 0 1 2 2 1 2 3)
       (3 2 1 2 2 1 0 1 3 2 1 2)
       (4 3 2 1 3 2 1 0 4 3 2 1)
       (2 3 4 5 1 2 3 4 0 1 2 3)
       (3 2 3 4 2 1 2 3 1 0 1 2)
       (4 3 2 3 3 2 1 2 2 1 0 1)))

(defconstant parity
  #(1 0 1 0  0 1 0 1  1 0 1 0))

(defun calc-distance (board)
  (loop for i from 0
        for j across board
        sum (aref distance j i)))

(defun limit-modified-by-parity (start goal lower)
  (if (= (aref parity (position 0 start))
         (aref parity (position 0 goal)))
      (if (evenp lower) lower (1+ lower))
      (if (oddp  lower) lower (1+ lower)))) 

(defun dfs-lower (fn board goal n limit space move lower)
  (if (= n limit)
      (when (equalp board goal)
        (funcall fn (cdr (reverse move))))
      (loop as x in (aref adjacent space)
            as p = (aref board x)
            as new-lower = (+ lower (- (aref distance p space)
                                       (aref distance p x)))
            do (when (and (/= p (car move))
                          (<= (+ new-lower n) limit))
                 (setf (aref board space) p
                       (aref board x) 0)
                 (dfs-lower fn board goal (1+ n) limit x (cons p move) new-lower)
                 (setf (aref board space) 0
                       (aref board x) p)))))

(defun solver-id-lower (start goal)
  (loop with lower = (calc-distance start)
        for i from (limit-modified-by-parity start goal lower) to 53 by 2
        do (format t "----- ~d -----~%" i)
        (dfs-lower
          (lambda (xs) (format t "~a~%" xs) (return-from solver-id-lower))
          start
          goal
          0
          i
          (position 0 start)
          '(-1)
          lower)))

(time (solver-id-lower #(0 3 2 1 8 7 6 5 4 11 10 9) #(1 2 3 4 5 6 7 8 9 10 11 0)))
