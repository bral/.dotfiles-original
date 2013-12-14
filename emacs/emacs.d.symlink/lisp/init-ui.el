(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-hl-line-mode +1)
(setq inhibit-splash-screen t)
(setq ring-bell-function 'ignore)

;; enable line numbers
(require-package 'linum)
(global-linum-mode 1)

(provide 'init-ui)
