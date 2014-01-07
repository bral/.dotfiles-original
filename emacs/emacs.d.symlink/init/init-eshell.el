(global-set-key (kbd "A-M-;") 'eshell-command)
(global-set-key (kbd "A-M-:") 'eshell)

; (setq linum-disabled-modes-list
;       ‘(eshell-mode wl-summary-mode compilation-mode))

; (defun linum-on ()
;   (unless (or (minibufferp)
;               (member major-mode linum-disabled-modes-list))
;     (linum-mode 1)))

(setq eshell-banner-message "")

;; Prompt
(setq eshell-prompt-function
      (lambda nil
	(concat
	 (propertize (eshell/pwd) 'face `(:foreground "#0087ff"))
	 (propertize "\nε" 'face `(:foreground "white"))
	 (propertize " : " 'face `(:foreground "grey")))))

(setq eshell-highlight-prompt nil)

;; Set prompt regexp so eshell can exit.
;; This is necessary since our prompt has a newline.
(setq eshell-prompt-regexp "^[^#$\n]*[ε] : ")

(require-package 'multi-eshell)
(define-key mac-key-mode-map [(alt :)] 'multi-eshell)

(provide 'init-eshell)
