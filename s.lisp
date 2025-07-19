(defun comb (n k)
    (cond
      ((zerop k) 1)
      ((zerop n) 0)
      (t (+ (comb (1- n) k) (comb (1- n) (1- k))))))

(defun prob (m n k)
  (let* ((c (loop as i from 0 below k sum (comb n i)))
         (d (/ c (expt 2 n))))
    (float (- 1 (expt d m))))) 

(defun memoize (func)
  (let ((table (make-hash-table :test #'equal)))
    #'(lambda (&rest args)
        (let ((value (gethash args table nil)))
          (unless value
            (setf value (apply func args))
            (setf (gethash args table) value))
          value))))

(setf (symbol-function 'comb) (memoize #'comb))

(loop as i from 1 as p = (prob i 40 24)
      do (format t "~2d: ~,4,0g~%" i p) until (> p 0.99))
