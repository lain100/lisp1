(loop with str = (read-line)
      with htb = (make-hash-table)
      as ch across (string-downcase str)
      as val = (gethash ch htb)
      when (char<= #\a ch #\z)
      do (setf (gethash ch htb) (if val (1+ val) 1))
      finally (loop as key being the hash-keys in htb using (hash-value val)
                    collect key into keys
                    collect val into vals
                    finally (format t "~@{~a~%~}" str keys vals (apply #'+ vals))))
