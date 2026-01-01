(defun viewing-angle (gap dist) (* (atan (/ gap 2 dist)) 60 360 (/ PI)))
(defun eyesight (gap &optional (dist 5.15662027)) (/ (viewing-angle gap dist)))
(defun logMAR (gap &optional (dist 5.15661644)) (log (viewing-angle gap dist) 10))

(loop as times in '(1 1.25892 1.5849 1.99525 2.5119 3.1623 3.9811 5.0119 6.3096 7.9432 10 12.59 15.85 19.951 25.12)
      as gap = (/ 15 1000 times)
      do (format t "~@{~6f ~}~%" (eyesight gap) (logMAR gap)))
