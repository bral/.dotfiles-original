;; Use normal tabs in makefiles
(add-hook 'makefile-mode-hook 'indent-tabs-mode)

(setq-default show-trailing-whitespace nil)
(setq-default indent-tabs-mode nil)

(provide 'init-whitespace)
