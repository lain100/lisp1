(require :split-sequence)
(use-package :split-sequence)

(loop as file in '("../講師給与・報酬_202606_01960.csv"
                   "../講師給与・報酬_202606_01961.csv")
  do (With-open-file (in file)
       (read-line in nil)
       (loop with props = (split-sequence #\, (read-line in nil))
             as idx in '(1 3 4 5 6 7 42 39 40 41 47)
             collect (string-right-trim '(#\) (nth idx props)) into prp
             finally (format t "~10{  ~3a~}~a~%~%" prp (nth 10 prp)))
       (loop as line = (read-line in nil) while line
             as items = (split-sequence #\, line)
             as amount = (loop as i in '(39 40)
                               as j in '(41 47)
                               with bs-slry = (read-from-string (nth 34 items))
                               collect (+ bs-slry
                                          (read-from-string (nth i items))) into amt
                               collect    (read-from-string (nth j items))  into lst
                               finally (return (append `(,bs-slry) amt '(50 100) lst)))
             
             as quantity = (loop as idx in '(3 4 5 6 7 42)
                                 collect (read-from-string (nth idx items)))
             as salary = (loop as qnt in quantity
                               as amt in amount
                               sum (floor (* qnt amt)))
             do (format t "~a~{~5f ~}~{~5d ~}~a ~d~%~%" (cadr items) quantity amount
                        (= (seventh amount) salary) salary))))
