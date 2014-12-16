(setq caps-lock-modifier "A-C-M")

;; Caps Lock
(defun caps-lock-bind (key)
  (kbd (concat caps-lock-modifier "-" key)))

;; Better line openings.
(defun bindings/open-line-below ()
  (interactive)
  (point-to-register 1)
  (end-of-line)
  (newline)
  (indent-for-tab-command)
  (beginning-of-line)
  (delete-trailing-whitespace)
  (jump-to-register 1))

(defun bindings/open-line-above ()
  (interactive)
  (point-to-register 1)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command)
  (beginning-of-line)
  (delete-trailing-whitespace)
  (jump-to-register 1))

(defun elscreen-create-last-buffer ()
  "Create a new screen with the current buffer."
  (interactive)
  (elscreen-create)
  (spacemacs/last-buffer))

(defun elscreen-kill-maybe ()
  "Kill current screen if screens remain; otherwise
kill emacs."
  (interactive)
  (if
      (/= (length (elscreen-get-screen-list)) 1)
      (elscreen-kill)
    (save-buffers-kill-emacs)))
