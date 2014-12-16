(setq caps-lock-modifier "A-C-M")

;; Caps Lock
(defun caps-lock-bind (key)
  (kbd (concat caps-lock-modifier "-" key)))

;; Better line openings.
(defun open-line-below ()
  (interactive)
  (point-to-register 1)
  (end-of-line)
  (newline)
  (indent-for-tab-command)
  (beginning-of-line)
  (delete-trailing-whitespace)
  (jump-to-register 1))

(defun open-line-above ()
  (interactive)
  (point-to-register 1)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command)
  (beginning-of-line)
  (delete-trailing-whitespace)
  (jump-to-register 1))

