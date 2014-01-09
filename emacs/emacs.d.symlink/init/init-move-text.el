(require-package 'move-text)

;; Set your bindings in `init-local.el`.
;;
;; For M-up and M-down bindings:
;; (move-text-default-bindings)
;;
;; Custom bindings example:
;; (global-set-key (kbd "M-P") 'move-text-up)
;; (global-set-key (kbd "M-N") 'move-text-down)

(eval-after-load 'js2r-mode
  '(set-local-key (kbd "M-n") 'move-text-up))

(provide 'init-move-text)
