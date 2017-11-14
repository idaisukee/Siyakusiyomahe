(defun S-next-block ()
    (interactive)
    (while
        (not
            (looking-at "

"))
        (forward-char))
    (next-line 2)
    (beginning-of-line))

(defun s-previous-block ()
    (interactive)
    (backward-char)
    (while
        (not
            (looking-back "

"))
        (backward-char))
    (previous-line 0)
    (beginning-of-line))




(defun Sy-n-b ()
    (interactive)
    (let*
        (
            (newline "
"))
        
        (cond
            (
                (looking-at newline)
                (princ "a")
                (while
                    (looking-at newline)
                    (next-line)))
            (t
                (princ "b")
                (princ "c")
                (search-forward (s-concat newline newline))))))


(provide 'Siyakusiyomahe)
