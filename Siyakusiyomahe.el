(require 's)

(setq Sy-newline "
")


(defun Sy-beginning-of-buffer? ()
    (cond
        (
            (= (point) (point-min)))))

(defun Sy-end-of-buffer? ()
    (cond
        (
            (= (point) (point-max)))))

(defun Sy-beginning-of-block? ()
    (interactive)
    (or
        (Sy-beginning-of-buffer?)
        (and
            (Sy-in-block?)
            (looking-back Sy-2-newlines))))

(defun Sy-end-of-block? ()
    (interactive)
    (or
        (Sy-end-of-buffer?)
        (and
            (Sy-in-block?)
            (looking-at Sy-2-newlines))))

(defun Sy-out-block? ()
    (cond
        (
            (Sy-beginning-of-buffer?)
            (looking-at Sy-newline))
        (
            (Sy-end-of-buffer?)
            (looking-back Sy-newline))
        (t
            (and
                (looking-back Sy-newline)
                (looking-at Sy-newline)))))

(defun Sy-blank-line? ()
    (save-excursion
        (beginning-of-line)
        (while
            (or
                (looking-at " ")
                (looking-at "	"))
            (forward-char))
        (eolp)))

(defun Sy-in-block? ()
    (not
        (Sy-out-block?)))

(defun Sy-beginning-of-block ()
    (interactive)
    (while
        (Sy-in-block?)
        (backward-char))
    (forward-char))

(defun Sy-beginning-of-block ()
    (interactive)
    (while
        (not
            (Sy-beginning-of-block?))
            (backward-char)))

(defun Sy-climb-out ()
    (interactive)
    (while
        (Sy-in-block?)
        (previous-line)))

(defun Sy-climb-in ()
    (interactive)
    (while
        (Sy-out-block?)
        (previous-line)))

(defun Sy-previous-block ()
    (interactive)
    (cond
        (
            (Sy-in-block?)
            (Sy-climb-out)
            (Sy-climb-in)
            (Sy-beginning-of-block))
        (
            t
            (Sy-climb-in)
            (Sy-beginning-of-block))))

(bind-key "C-;" 'Sy-climb-out)
(bind-key "C-:" 'Sy-climb-in)

(bind-key "C-;" 'Sy-previous-block)
(bind-key "C-:" 'Sy-beginning-of-block)

(bind-key "C-:" 'Sy-end-of-block?)

(provide 'Siyakusiyomahe)


