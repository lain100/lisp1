(with-open-file (out "result.txt"
                     :DIRECTION :OUTPUT
                     :IF-EXISTS :APPEND
                     :IF-DOES-NOT-EXIST :CREATE)
  (loop with a = (char-code #\a)
        as str = (loop as ch across (string-downcase (read-line))
                       unless (char<= #\a ch #\z) collect ch
                       else collect (code-char (+ (mod (+ (- (char-code ch) a) 13) 26) a)))
        as limit = (if str 2 1) then (if str 2 (1- limit))
        while (plusp limit)
        do (loop with str = (coerce str 'string)
                 as stream in `(t ,out) do (print str stream))))
