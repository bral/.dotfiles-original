(require-package 'multiple-cursors)

;; setup bindings
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "H-d") 'mc/mark-next-like-this)

(provide 'init-multicursor)
