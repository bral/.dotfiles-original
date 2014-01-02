;; Use normal tabs in makefiles
(add-hook 'makefile-mode-hook 'indent-tabs-mode)

(setq-default show-trailing-whitespace t)
(setq-default indent-tabs-mode nil)

(provide 'init-whitespace)
