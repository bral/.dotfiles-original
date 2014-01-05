;; Ignore .DS_Store in ido
(eval-after-load 'ido '(add-to-list 'ido-ignore-files "\\.DS_Store"))

;; Setup environment variables from the user's shell.
(require-package 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;; Rebind mod keys
(require-package 'redo+)
(require-package 'mac-key-mode)

;; Default keysets
(mac-key-mode 1)
(setq mac-command-modifier 'alt)
(setq mac-option-modifier 'meta)

;; Open preferences
(global-set-key (kbd "A-,") 'customize)

;; Use brew's aspell for spellcheck
(setq ispell-program-name "/usr/local/bin/aspell")

;; Make scrolling less jerky
(setq mouse-wheel-scroll-amount '(0.001))
(setq mouse-wheel-progressive-speed nil)

(provide 'init-mac)
