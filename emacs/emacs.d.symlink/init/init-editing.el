;; copy an inactive line
(require-package 'whole-line-or-region)

;; basic config
(setq-default
 show-trailing-whitespace t)

;; auto-revert any open files/buffers
(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t
  auto-revert-verbose nil)

;; cleanup any trailing any whitespace
(require-package 'whitespace-cleanup-mode)
(global-whitespace-cleanup-mode t)

;; initialize the undo tree
(require-package 'undo-tree)
(global-undo-tree-mode)
(diminish 'undo-tree-mode)

;; highlight symbols
(require-package 'highlight-symbol)
(dolist (hook '(prog-mode-hook html-mode-hook))
  (add-hook hook 'highlight-symbol-mode)
  (add-hook hook 'highlight-symbol-nav-mode))
(eval-after-load 'highlight-symbol
  '(diminish 'highlight-symbol-mode))

;; expand regions
(require-package 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
