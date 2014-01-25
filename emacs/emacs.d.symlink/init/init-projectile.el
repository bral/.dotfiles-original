(require-package 'projectile)

(projectile-global-mode 1)

(define-prefix-command (key-binding (kbd "s-p")))

(global-set-key (kbd "s-p") 'projectile-commander)

(define-key projectile-mode-map (kbd "s-p ?") 'projectile-commander)
(define-key projectile-mode-map (kbd "s-p d") 'projectile-find-dir)
(define-key projectile-mode-map (kbd "s-p p") 'projectile-switch-project)
(define-key projectile-mode-map (kbd "s-p f") 'projectile-find-file)
(define-key projectile-mode-map (kbd "s-p e") 'projectile-recentf)
(define-key projectile-mode-map (kbd "s-p r") 'projectile-replace)
(define-key projectile-mode-map (kbd "s-p R") 'projectile-regenerate-tags)
(define-key projectile-mode-map (kbd "s-p g") 'projectile-grep)
(define-key projectile-mode-map (kbd "s-p c") 'projectile-compile-project)

;; (require 'derp)

(provide 'init-projectile)
