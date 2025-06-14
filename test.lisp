(defvar *comb-table* nil)

(defun comb-dp-sub (n r)
  (if (or (zerop r) (= n r))
      1
      (+ (aref *COMB-TABLE* (1- n) r) (aref *COMB-TABLE* (1- n) (1- r)))))

(defun comb-dp (n r)
  (setf *COMB-TABLE* (make-array (list (1+ n) (1+ n))))
  (loop as i from 0 to n
        do (loop as j from 0 to i
                 do (setf (aref *COMB-TABLE* i j) (comb-dp-sub i j)))
        finally (return (aref *COMB-TABLE* n r))))

(time (comb-dp 6 3))

(defun comb-dp1 (n r)
  (loop with table = (make-array (1+ n) :initial-element 1)
        as i from 2 to n
        do (loop as j downfrom (1- i) above 0
                 do (incf (aref table j) (aref table (1- j))))
        finally (return (aref table r))))

(loop as i from 0 to 10 do (print (comb-dp1 10 i)))

(defun comb (n r)
  (if (or (zerop r) (= n r))
      1
      (+ (comb (1- n) r) (comb (1- n) (1- r)))))

(defun memoize (func)
  (let ((table (make-hash-table :test #'equal)))
    #'(lambda (&rest args)
        (let ((value (gethash args table nil)))
          (unless value
            (setf value (apply func args))
            (setf (gethash args table) value))
          value))))

; memoizeで分割統治法
(setf (symbol-function 'comb) (memoize #'comb))

(time (comb 30 15))

(defun part-num (n k)
  (cond ((or (zerop n) (= n 1) (= k 1)) 1)
        ((or (< n 0) (< k 1)) 0)
        (t (+ (part-num (- n k) k) (part-num n (1- k))))))

(defun partition-number (n)
  (part-num n n))

(setf (symbol-function 'part-num) (memoize #'part-num))

(time (partition-number 100))

(defun partition-number1 (n)
  (loop with a = (make-array (1+ n) :INITIAL-ELEMENT 1)
        as k from 2 to n
        do (loop as m from k to n
                 do (incf (aref a m) (aref a (- m k))))
        finally (return (aref a n))))

(time (partition-number1 100))

(defun power-set (func xs &optional (a nil))
  (cond
    ((null xs) (funcall func (reverse a)))
    (t
     (power-set func (cdr xs) a)
     (power-set func (cdr xs) (cons (car xs) a)))))

(defun subset-sum (xs n)
  (power-set #'(lambda (ys) (when (= (apply #'+ ys) n) (print ys))) xs))

(subset-sum '(1 2 3 4 5 6) 10)

(defun lcar (s) (car s))

(defun lcdr (s)
  (when (functionp (cdr s))
    (setf (cdr s) (funcall (cdr s))))
  (cdr s))

(defmacro lcons (a b)
  `(cons ,a (lambda () ,b)))

(defun lmap (proc &rest s)
  (if (member nil s)
      nil
      (lcons (apply proc (mapcar #'lcar s))
             (apply #'lmap proc (mapcar #'lcdr s)))))

(defun take (strm n)
  (loop as s = strm then (lcdr s) repeat n
        until (null s) collect (lcar s)))

(defvar *fibo*)

(setf *FIBO* (lcons 0 (lcons 1 (lmap #'+ (lcdr *FIBO*) *FIBO*)))
      *FIBO* (cddr (take *FIBO* 32)))

(defun test (func)
  (loop as x in '(26 27 28 29 30)
        as xs = (subseq *FIBO* 0 x)
        as s = (get-internal-real-time)
        ; do (funcall func xs (1- (apply #'+ xs)))
        do (funcall func xs (1- (car (last xs))))
        do (print (float (/ (- (get-internal-real-time) s)
                            internal-time-units-per-second)))))

;subset-sum は要素数 n とすると実行時間 2^n に比例する関数
(test #'subset-sum)

;s > n, s + r < n で枝刈り
(defun subset-sum1 (xs n)
  (labels ((iter (xs s r a)
             (cond ((= s n)
                    (print (reverse a)))
                   ((<= s n (+ s r))
                    (let ((x (car xs)))
                      (iter (cdr xs) s (- r x) a)
                      (iter (cdr xs) (+ s x) (- r x) (cons x a)))))))
    (iter (shuffle xs) 0 (apply #'+ xs) nil)))

(test #'subset-sum1)

(defun shuffle (xs &aux (vec (coerce xs 'vector)))
  (loop as i from 1 below (length vec)
        do (rotatef (aref vec i) (aref vec (random (1+ i)))))
  (coerce vec 'list))

(shuffle '(1 2 3 4 5))

(defun subset-sum-dp (xs n)
  (let ((table (make-array (1+ n) :INITIAL-ELEMENT nil)))
    (setf (aref table 0) t)
    (loop as x in xs
          do (loop as y downfrom (- n x) to 0
                   when (aref table y)
                   do (setf (aref table (+ x y)) t)))
    (print (aref table n))))

(test #'subset-sum-dp)

(defun get-name (item) (car item))
(defun get-size (item) (cadr item))
(defun get-price (item) (caddr item))

(defun knapsack (item-list knap-size)
  (loop with gain = (make-array (1+ knap-size) :INITIAL-ELEMENT 0)
        with choice = (make-array (1+ knap-size) :INITIAL-ELEMENT nil)
        as item in item-list
        do (loop as i from (get-size item) to knap-size
                 as j from 0
                 as new-price = (+ (get-price item) (aref gain j))
                 when (< (aref gain i) new-price)
                 do (setf (aref gain i) new-price
                          (aref choice i) item))
        finally (return (print-answer choice knap-size))))

(defun collect-item (choice knap-size)
  (loop as i = knap-size then (- i (get-size (aref choice i)))
        until (null (aref choice i)) collect (aref choice i)))

(defun count-item (xs &aux ys)
  (loop as x in xs
        as y = (assoc x ys)
        if y do (incf (cdr y))
        else do (push (cons x 1) ys))
  ys)

(defun print-answer (choice knap-size)
  (loop with (size price) = '(0 0)
        as x in (count-item (collect-item choice knap-size))
        do (format t "~a, ~d~%" (car x) (cdr x))
        do (incf size (* (get-size (car x)) (cdr x)))
        do (incf price (* (get-price (car x)) (cdr x)))
        finally (format t "size: ~d, price: ~d~%" size price)))

(knapsack '((a 4 6) (b 3 4) (c 1 1)) 10)

