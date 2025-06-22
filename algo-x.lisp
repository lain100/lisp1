(defun make-l-tromino (w h)
  (loop as x from 0 below (1- w)
        append (loop as y from 0 below (1- h)
                     as z = (+ (* y w) x)
                     collect (list z (1+ z) (+ z w))
                     collect (list z (1+ z) (+ z w 1))
                     collect (list z (+ z w) (+ z w 1))
                     collect (list (1+ z) (+ z w) (+ z w 1)))))

(defun duplicatep (xs ls)
  (loop as x in xs if (member x ls) return t))

(defun combination (f n ls &optional a b)
  (cond ((zerop n) (funcall f a))
        ((< (length ls) n) nil)
        (t
         (unless (duplicatep (car ls) b)
           (combination f (1- n) (cdr ls) (cons (car ls) a) (append (car ls) b)))
         (combination f n (cdr ls) a b))))

(combination #'print 5 (make-l-tromino 4 4))

(defun solvar-l-tromino-1 (f n m)
  (let ((tbl (make-l-tromino n n)))
    (combination f
                 (truncate (* n n) 3)
                 (remove-if (lambda (xs) (member m xs)) tbl))))

(solvar-l-tromino-1 #'print 4 0)

(defun solvar-l-tromino (f n)
  (combination f
               (/ (* n n) 3)
               (make-l-tromino n n)))

(let ((c 0))
  (solvar-l-tromino-1 (lambda (x) (if (zerop c) (print x)) (incf c)) 5 12) c)

(let ((c 0))
  (solvar-l-tromino (lambda (x) (if (zerop c) (print x)) (incf c)) 6) c)

(defun make-matrix (xs)
  (loop with ls = (make-array (length xs) :INITIAL-CONTENTS xs)
        with cs = nil
        as y from 0 below (length ls)
        do (loop as x in (aref ls y)
                 as zs = (assoc x cs)
                 if zs do (rplacd zs (cons y (cdr zs)))
                 else do (push (list x y) cs))
        finally (return (list ls cs))))

(defvar s '((1 2) (2 3) (3 4) (1 5) (5) (2)))

(make-matrix s)

(defun search-min-column (cs)
  (loop with min-size = (loop as c in cs minimize (length c))
        as c in cs when (= (length c) min-size) return c))

(search-min-column s)

(defun get-num (xs) (car xs))
(defun get-subsets (xs) (cdr xs))

(defun remove-columns (xs cs)
  (loop as c in cs if (member (get-num c) xs) collect c into drops
        else collect c into takes
        finally (return (values takes drops))))

(remove-columns (car s) (second (make-matrix s)))

(defun remove-subsets (ys cs)
  (mapcar (lambda (zs)
            (cons (get-num zs)
                  (loop as z in (get-subsets zs) unless (member z ys) collect z)))
          cs))

(remove-subsets `(0 1 3 5) (remove-columns (car s) (second (make-matrix s))))

(defun collect-subsets (cs)
  (loop as buff = nil then (union (get-subsets zs) buff)
        as zs in cs finally (return buff)))

(multiple-value-bind (x y)
    (remove-columns (car s) (second (make-matrix s)))
  (declare (ignore x)) (collect-subsets y))

(defun algo-x (f lines columns &optional a)
  (if (null columns)
      (funcall f a)
      (loop as x in (get-subsets (search-min-column columns))
            as cs = (aref lines x)
            do (multiple-value-bind (takes drops)
                   (remove-columns cs columns)
                 (algo-x f
                         lines
                         (remove-subsets (collect-subsets drops) takes)
                         (cons cs a))))))

(apply #'algo-x #'print (make-matrix s))

(make-l-tromino 6 6)

(defun solver-l-tromino-1-x (f n m)
  (let ((mat (make-matrix (loop as xs in (make-l-tromino n n)
                                unless (member m xs) collect xs))))
    (apply #'algo-x f mat)))

(defun solver-l-tromino-x (f n)
  (let ((mat (make-matrix (make-l-tromino n n))))
    (apply #'algo-x f mat)))

(solver-l-tromino-1-x #'print 4 0)

(let ((c 0))
  (solver-l-tromino-x (lambda (x) (if (zerop c) (print x)) (incf c)) 6) c)

(time (let ((c 0))
        (solver-l-tromino-1-x (lambda (x) (if (zerop c) (print x)) (incf c)) 8 0) c))
