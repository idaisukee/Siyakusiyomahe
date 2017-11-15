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

(defun Sy-dive-out ()
    (interactive)
    (while
        (Sy-in-block?)
        (next-line)))

(defun Sy-dive-in ()
    (interactive)
    (while
        (Sy-out-block?)
        (next-line)))

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

(defun Sy-next-block ()
    (interactive)
    (cond
        (
            (Sy-in-block?)
            (Sy-dive-out)
            (Sy-dive-in)
            (Sy-beginning-of-block))
        (
            t
            (Sy-dive-in)
            (Sy-beginning-of-block))))

(provide 'Siyakusiyomahe)
