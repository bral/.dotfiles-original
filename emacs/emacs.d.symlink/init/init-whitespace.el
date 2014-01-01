;; Use normal tabs in makefiles
(add-hook 'makefile-mode-hook 'indent-tabs-mode)

(setq-default show-trailing-whitespace t)

;; cleanup any trailing any whitespace
(require-package 'whitespace-cleanup-mode)
(global-whitespace-cleanup-mode t)

(provide 'init-whitespace)
