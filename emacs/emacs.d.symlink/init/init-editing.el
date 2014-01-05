;; Copy an inactive line
(require-package 'whole-line-or-region)

;; Auto-revert any open files/buffers
(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t
  auto-revert-verbose nil)

;; Highlight symbols
(require-package 'highlight-symbol)
(dolist (hook '(prog-mode-hook html-mode-hook))
  (add-hook hook 'highlight-symbol-mode)
  (add-hook hook 'highlight-symbol-nav-mode))
(eval-after-load 'highlight-symbol
  '(diminish 'highlight-symbol-mode))

;; Expand regions
(require-package 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; Comment like Sublime Text
(global-set-key (kbd "A-/") 'comment-or-uncomment-region)

(provide 'init-editing)
