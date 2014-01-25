(require-package 'projectile)

(projectile-global-mode 1)

(define-prefix-command (key-binding (kbd "A-p")))

(global-set-key (kbd "A-p P") 'projectile-mode)

(define-key projectile-mode-map (kbd "A-p ?") 'projectile-commander)
(define-key projectile-mode-map (kbd "A-p d") 'projectile-find-dir)
(define-key projectile-mode-map (kbd "A-p p") 'projectile-switch-project)
(define-key projectile-mode-map (kbd "A-p f") 'projectile-find-file)
(define-key projectile-mode-map (kbd "A-p e") 'projectile-recentf)
(define-key projectile-mode-map (kbd "A-p r") 'projectile-replace)
(define-key projectile-mode-map (kbd "A-p R") 'projectile-regenerate-tags)
(define-key projectile-mode-map (kbd "A-p g") 'projectile-grep)
(define-key projectile-mode-map (kbd "A-p c") 'projectile-compile-project)

(require-package 'eproject)
(require 'eproject)

;; NPM JavaScript project
(define-project-type javascript-npm (generic)
  (or (look-for "package.json")
      (look-for "node_modules"))
  :irrelevant-files ("node_modules/")
  :tasks (("test" :shell "npm test")))

(provide 'init-project)
