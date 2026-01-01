(With-open-file (in "講師給与・報酬_202511_01961.csv")
  (require :split-sequence)
  (read-line in nil)
  (format t "~{  ~3a~}~%"
          (loop with props = (split-sequence:SPLIT-SEQUENCE #\, (read-line in nil))
                as idx in '(0 3 4 5 6 7 41 38 39 40 46)
                collect (string-right-trim '(#\) (nth idx props))))
  (loop as line = (read-line in nil) while line
        as items = (split-sequence:split-sequence #\, line)
        as selection = (loop as i in '(38 39)
                             as j in '(40 46)
                             with basic-salary = (read-from-string (nth 34 items))
                             collect (+ (read-from-string (nth i items)) basic-salary) into sc1
                             collect (read-from-string (nth j items)) into sc2
                             finally (return (append (list basic-salary) sc1 '(50 100) sc2)))
        as magnification = (loop as idx in '(3 4 5 6 7 41)
                                 collect (read-from-string (nth idx items)))
        do (format t "~a~{~5f ~}~{~5d ~} -> ~5d~%" (car items) magnification selection
                   (loop as times in magnification
                         as amount in selection
                         sum (rational (* times amount))))))
