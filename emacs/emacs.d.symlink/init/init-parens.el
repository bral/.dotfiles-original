;; auto pair
(when (fboundp 'electric-pair-mode)
  (setq-default electric-pair-mode 1))

;; match parens
(show-paren-mode 1)

;; Init paredit
(require-package 'paredit)
(autoload 'enable-paredit-mode "paredit")
(paredit-mode 1)

;; Use paredit everywhere
(require-package 'paredit-everywhere)
(add-hook 'css-mode-hook 'paredit-everywhere-mode)

(provide 'init-parens)
