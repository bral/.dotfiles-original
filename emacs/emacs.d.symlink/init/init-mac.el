;; Ignore .DS_Store in ido
(eval-after-load 'ido '(add-to-list 'ido-ignore-files "\\.DS_Store"))

;; Use brew's aspell for spellcheck
(setq ispell-program-name "/usr/local/bin/aspell")

;; Make scrolling less jerky
(setq mouse-wheel-scroll-amount '(0.001))
(setq mouse-wheel-progressive-speed nil)

;; Rebind mod keys
;(setq mac-command-modifier 'hyper)
(setq mac-option-modifier 'meta)

(provide 'init-mac)
