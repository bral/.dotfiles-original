;; Jump
(require-package 'window-jump)
(global-set-key (caps-lock-bind "h") 'windmove-left)
(global-set-key (caps-lock-bind "j") 'windmove-down)
(global-set-key (caps-lock-bind "k") 'windmove-up)
(global-set-key (caps-lock-bind "l") 'windmove-right)

;; Number
(require-package 'switch-window)
(require 'switch-window)
(setq switch-window-shortcut-style 'alphabet)
(global-set-key (caps-lock-bind "<return>") 'switch-window)

;; Split
(global-set-key (caps-lock-bind "s") 'split-window-horizontally)
(global-set-key (caps-lock-bind "v") 'split-window-vertically)
;; Focus after split
(defadvice split-window (after move-point-to-new-window activate)
  "Moves the point to the newly created window after splitting."
  (other-window 1))

;; Minimize / maximize
(global-set-key (caps-lock-bind "x") 'delete-window)
(global-set-key (caps-lock-bind "f") 'delete-other-windows)

;; Cycle
(global-set-key (caps-lock-bind "n") (λ (other-window 1)))
(global-set-key (caps-lock-bind "p") (λ (other-window -1)))

;; Modes
(require-package 'golden-ratio)
(global-set-key (caps-lock-bind "g") 'golden-ratio-mode)

(provide 'init-window-manage)
