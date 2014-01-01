;; copy an inactive line
(require-package 'whole-line-or-region)

(whole-line-or-region-mode t)
(diminish 'whole-line-or-region-mode)
(make-variable-buffer-local 'whole-line-or-region-mode)

(provide 'init-wholeline)
