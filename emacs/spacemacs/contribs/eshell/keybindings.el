(global-set-key (kbd "A-M-;") 'eshell-command)
(global-set-key (kbd "A-M-:") 'eshell)

(setq eshell-banner-message "")

;; Prompt
(setq eshell-prompt-function
      (lambda ()
        (concat
        (propertize (eshell/pwd) 'face `(:foreground "#0087ff"))
        (propertize "\nε" 'face `(:foreground "white"))
        (propertize " : " 'face `(:foreground "grey")))))

(setq eshell-highlight-prompt nil)

;; Set prompt regexp so eshell can exit.
;; This is necessary since our prompt has a newline.
(setq eshell-prompt-regexp "^[^#$\n]*[ε] : ")
