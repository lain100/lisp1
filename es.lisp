(loop with irregs = '(("have" . "has"))
      with vowels = "aeiou"
      as str = (string-downcase (read-line))
      as len = (length str)
      while (> len 1)
      as t1 = (char str (1- len))
      as t2 = (char str (- len 2))
      as irreg = (assoc str irregs :test #'string=)
      when irreg
      do (setf str (cdr irreg))
      else when (or (find t1 "sox")
                    (and (find t2 "cs") (char= t1 #\h)))
      do (setf str (format nil "~aes" str))
      else when (and (not (find t2 vowels))
                     (char= t1 #\y))
      do (setf str (format nil "~aies" (subseq str 0 (1- len))))
      else
      do (setf str (format nil "~as" str))
      do (format t "~s~%" str))
