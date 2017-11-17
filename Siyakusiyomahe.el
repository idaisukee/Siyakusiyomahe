(require 'dash)
(require 's)

(setq Sy-newline "
")

(setq Sy-2-newlines (s-concat Sy-newline Sy-newline))

(defun Sy-beginning-of-buffer? ()
    (cond
        (
            (= (point) (point-min)))))

(defun Sy-end-of-buffer? ()
    (cond
        (
            (= (point) (point-max)))))

(defun Sy-beginning-of-block? ()
    (or
        (Sy-beginning-of-buffer?)
        (and
            (Sy-in-block?) ;;; TODO ここがだめ
            (Sy-out-block? -1))))

(defun Sy-end-of-block? ()
    (or
        (Sy-end-of-buffer?)
        (and
            (Sy-in-block?)
            (Sy-out-block 1))))

(defun Sy-out-block? (&optional line)
    (let*
        (
            (line* (or line 0)))
        (save-excursion
            (next-line line*)
            (beginning-of-line)
            (while
                (or
                    (looking-at " ")
                    (looking-at "	"))
                (forward-char))
            (eolp))))

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

(defun Sy-previous-block (arg)
    (interactive "P")
    (--dotimes (-> arg prefix-numeric-value)
        (cond
            (
                (Sy-in-block?)
                (Sy-climb-out)
                (Sy-climb-in)
                (Sy-beginning-of-block))
            (
                t
                (Sy-climb-in)
                (Sy-beginning-of-block)))))

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

(defun Sy-next-block (arg)
    (interactive "P")
    (--dotimes (-> arg prefix-numeric-value)
        (cond
            (
                (Sy-in-block?)
                (Sy-dive-out)
                (Sy-dive-in)
                (Sy-beginning-of-block))
            (
                t
                (Sy-dive-in)
                (Sy-beginning-of-block)))))

(provide 'Siyakusiyomahe)


(defun Sy-top-of-buffer? ()
    (save-excursion
        (beginning-of-line)
        (Sy-beginning-of-buffer?)))

(defun Sy-top-of-block? ()
    (or
        (Sy-top-of-buffer?)
        (and
            (Sy-in-block?)
            (Sy-out-block? -1))))

(defun Sy-top-of-block ()
    (interactive)
    (cond
        
        (
            (Sy-in-block?)
            (while
                
                (not
                    (Sy-top-of-block?))
                (next-line -1)))))

(defun Sy-beginning-of-block ()
    (interactive)
    (Sy-top-of-block)
    (beginning-of-line)
    (Sy-parenchyma))

(defun Sy-beginning-of-block? ()
    (save-excursion)
    (Sy-stroma)
    (bolp))

(defun Sy-parenchyma ()
    (interactive)
    (while
        (or
            (looking-at " ")
            (looking-at "	"))
        (forward-char)))

(defun Sy-stroma ()
    (interactive)
    (while
        (or
            (looking-back " ")
            (looking-back "	"))
        (forward-char -1)))

(defun Sy-climb-in ()
    (interactive)
    (while
        (and
            (Sy-out-block?)
            (not
                (Sy-top-of-buffer?)))
        (next-line -1)))

(defun Sy-climb-out ()
    (interactive)
    (while
        (and
            (Sy-in-block?)
            (not
                (Sy-top-of-buffer?)))
        (next-line -1)))

(defun Sy-previous-block ()
    (interactive)
    (cond
        (

            (Sy-out-block?)
            (Sy-climb-in)
            (Sy-beginning-of-block))
        (
            (and
                (Sy-in-block?)
                (Sy-beginning-of-block?)))
        (
            (and
                (Sy-in-block?)
                (not (Sy-beginning-of-block?)))
            )
            (Sy-climb-out)
            (Sy-cilmb-in)
            (Sy-beginning-of-block))))

(Sy-top-of-block?)
