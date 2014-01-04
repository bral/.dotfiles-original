(require-package 'magit)

(define-prefix-command (key-binding (kbd "A-g")))

(global-set-key (kbd "A-g s") 'magit-status)
(global-set-key (kbd "A-g t") 'magit-stash)
(global-set-key (kbd "A-g p") 'magit-push)
(global-set-key (kbd "A-g d") 'magit-diff)

(provide 'init-git)
