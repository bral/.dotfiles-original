(setq caps-lock-modifier "A-C-M")

(defun caps-lock-bind (key)
  (kbd (concat caps-lock-modifier "-" key)))

;; Split
(global-set-key (caps-lock-bind "s") 'split-window-horizontally)
(global-set-key (caps-lock-bind "v") 'split-window-vertically)

;; Minimize / maximize
(global-set-key (caps-lock-bind "w") 'delete-window)
(global-set-key (caps-lock-bind "-") 'delete-other-windows)
