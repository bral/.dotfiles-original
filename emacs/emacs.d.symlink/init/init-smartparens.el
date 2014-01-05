(require-package 'smartparens)

(require 'smartparens-config)

(setq sp-autoescape-string-quote nil)

(add-hook 'css-mode-hook 'turn-on-smartparens-mode)
(add-hook 'js2-mode-hook 'turn-on-smartparens-mode)

(provide 'init-smartparens)
