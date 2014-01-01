;; Navigate window layouts with C-c <left> and C-c <right>
(winner-mode 1)

;; Make "C-x o" prompt for a target window when there are more than 2
(require-package 'switch-window)
(require 'switch-window)
(setq switch-window-shortcut-style 'alphabet)

(provide 'init-windows)
