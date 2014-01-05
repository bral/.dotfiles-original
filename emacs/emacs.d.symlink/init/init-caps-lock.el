(setq caps-lock-modifier "A-C-M")

(defun caps-lock-bind (key)
  (kbd (concat caps-lock-modifier "-" key)))

(provide 'init-caps-lock)
