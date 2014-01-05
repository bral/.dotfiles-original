;; Prompt
(setq eshell-prompt-function
      (lambda nil
	(concat
	 (propertize (eshell/pwd) 'face `(:foreground "blue"))
	 (propertize "\nε" 'face `(:foreground "white"))
	 (propertize " : " 'face `(:foreground "grey")))))
(setq eshell-highlight-prompt nil)

;; Set prompt regexp so eshell can exit.
;; This is necessary since our prompt has a newline.
(setq eshell-prompt-regexp "^[^#$\n]*[ε] : ")

(require-package 'multi-eshell)
(define-key mac-key-mode-map [(alt :)] 'multi-eshell)

(provide 'init-eshell)
