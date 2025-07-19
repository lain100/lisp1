(defstruct dnode
  up down prev next header num (len 0))

(defun make-new-dnode (n)
  (let ((node (make-dnode :num n)))
    (setf (dnode-up node) node
          (dnode-down node) node
          (dnode-prev node) node
          (dnode-next node) node
          (dnode-header node) node)
    node))

(defvar *header*)

(defun init-header ()
  (setf *HEADER* (make-new-dnode -1)))

(defun make-dancing-links (xss)
  (init-header)
  (loop as line from 0
        as xs in xss
        as h-node = (make-new-dnode line)
        do (insert-column (car xs) h-node)
        do (loop as col in (cdr xs)
                 as node = (make-new-dnode line)
                 do (insert-column col node)
                 do (insert-line h-node node))))

(defun insert-line (header new-node)
  (let ((p-node (dnode-prev header)))
    (setf (dnode-next new-node) header
          (dnode-prev new-node) p-node
          (dnode-next p-node) new-node
          (dnode-prev header) new-node)
    new-node))

(defun insert-column (col new-node)
  (let* ((header (search-column col))
         (p-node (dnode-up header)))
    (incf (dnode-len header))
    (setf (dnode-up new-node) p-node
          (dnode-down new-node) header
          (dnode-up header) new-node
          (dnode-down p-node) new-node
          (dnode-header new-node) header)))

(defun search-column (col)
  (loop as node = (dnode-next *HEADER*) then (dnode-next node)
        if (eq node *HEADER*) return (insert-line *HEADER* (make-new-dnode col))
        if (eq (dnode-num node) col) return node))

(defun remove-header (node)
  (let* ((header (dnode-header node))
         (p-node (dnode-prev header))
         (n-node (dnode-next header)))
    (setf (dnode-prev n-node) p-node
          (dnode-next p-node) n-node)))

(defun remove-column (node)
  (let ((u-node (dnode-up node))
        (d-node (dnode-down node)))
    (setf (dnode-up d-node) u-node
          (dnode-down u-node) d-node)
    (decf (dnode-len (dnode-header node)))))

(defun remove-matrix (h-node)
  (loop as node = h-node then (dnode-next node)
        as done = nil then (eq node h-node)
        until done
        do (remove-header node)
        do (loop as c-node = (dnode-down node) then (dnode-down c-node)
                 until (eq c-node node)
                 unless (eq c-node (dnode-header c-node))
                 do (loop as l-node = (dnode-next c-node) then (dnode-next l-node)
                          until (eq l-node c-node)
                          do (remove-column l-node)))))

(defun restore-header (node)
  (let* ((header (dnode-header node))
         (p-node (dnode-prev header))
         (n-node (dnode-next header)))
    (setf (dnode-next p-node) header
          (dnode-prev n-node) header)))

(defun restore-colmun (node)
  (let ((u-node (dnode-up node))
        (d-node (dnode-down node)))
    (setf (dnode-up d-node) node
          (dnode-down u-node) node)
    (incf (dnode-len (dnode-header node)))))

(defun restore-matrix (h-node)
  (loop as node = (dnode-prev h-node) then (dnode-prev node)
        do (restore-header node)
        do (loop as c-node = (dnode-up node) then (dnode-up c-node)
                 until (eq c-node node)
                 unless (eq c-node (dnode-header c-node))
                 do (loop as l-node = (dnode-prev c-node) then (dnode-prev l-node)
                          until (eq l-node c-node)
                          do (restore-colmun l-node)))
        until (eq node h-node)))

(defun select-min-column ()
  (loop with min-node = (dnode-next *HEADER*)
        as node = (dnode-next min-node) then (dnode-next node)
        if (eq node *HEADER*) return min-node
        if (zerop (dnode-len node)) return node
        if (< (dnode-len node) (dnode-len min-node)) do (setf min-node node)))

(defun emptyp ()
  (eq *HEADER* (dnode-next *HEADER*)))

; (make-dancing-links '((1 2 3)(1 2 3)(1 2 3)))
; (dnode-len (select-min-column))
; (prog1 nil (init-header))
; (emptyp)

(defun algo-dlx-iter (f xs a)
  (if (emptyp)
      (funcall f a)
      (loop with c-node = (select-min-column)
            as l-node = (dnode-down c-node) then (dnode-down l-node)
            until (eq l-node c-node)
            do (remove-matrix l-node)
            do (algo-dlx-iter f xs (cons (aref xs (dnode-num l-node)) a))
            do (restore-matrix l-node))))

(defun algo-dlx (f xs)
  (make-dancing-links xs)
  (algo-dlx-iter f (make-array (length xs) :INITIAL-CONTENTS xs) nil))

; (algo-dlx #'print '((1 2) (2 3) (3 4) (1 5) (5) (2)))

(defun make-l-tromino (w h)
  (loop as x from 0 below (1- w)
        append (loop as y from 0 below (1- h)
                    as z = (+ (* w y) x)
                    collect (list z (1+ z) (+ z w))
                    collect (list z (1+ z) (+ z w 1))
                    collect (list z (+ z w) (+ z w 1))
                    collect (list (1+ z) (+ z w) (+ z w 1)))))

(defun solver-l-tromino-1-dlx (f n m)
  (algo-dlx f (remove-if #'(lambda (xs) (member m xs)) (make-l-tromino n n))))

(defun solver-l-tromino-dlx (f n)
  (algo-dlx f (make-l-tromino n n)))

(solver-l-tromino-1-dlx #'print 4 0)

(time (let ((c 0))
        (solver-l-tromino-dlx #'(lambda (x) (if (zerop c) (print x)) (incf c)) 9) c))

(time
  (let ((c 0))
    (solver-l-tromino-1-dlx #'(lambda (x) (if (zerop c) (print x)) (incf c)) 8 0) c))
