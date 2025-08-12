(loop with irregs =
      '(("begin" . "began") ("buy" . "bought") ("come" . "came") ("drink" . "drank") ("go" . "went") ("have" . "had") ("make" . "made") ("read" . "read") ("run" . "ran") ("say" . "said") ("see" . "saw") ("take" . "took") ("tell" . "told") ("think" . "thought") ("understand" . "understood") ("write" . "wrote"))
      with vowels = "aeiou"
      as str = (string-downcase (read-line))
      as len = (length str)
      while (> len 1)
      as t1 = (char str (1- len))
      as t2 = (char str (- len 2))
      as t3 = (and (> len 2) (char str (- len 3)))
      as irreg = (assoc str irregs :test #'string=)
      when irreg
      do (setf str (cdr irreg))
      else when (char= t1 #\e)
      do (setf str (format nil "~ad" str))
      else when (and (not (find t2 vowels)) (char= t1 #\y))
      do (setf str (format nil "~aied" (subseq str 0 (1- len))))
      else when (and (not (find t1 "xy"))
                     (not (find t3 vowels))
                     (find t2 vowels)
                     (not (find t1 vowels)))
      do (setf str (format nil "~a~aed" str t1))
      else
      do (setf str (format nil "~aed" str))
      do (format t "~s~%" str))
