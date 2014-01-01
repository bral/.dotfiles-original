(setq ring-bell-function 'ignore
      font-lock-maximum-decoration t
      color-theme-is-global t
      truncate-partial-width-windows nil)

;; Highlight current line
(global-hl-line-mode 1)

;; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

;; Setup GUI mode
(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (blink-cursor-mode -1))

(setq indicate-empty-lines t)

;; Make zooming affect frame instead of buffers
;; (require-package 'zoom-frm)

;; Cleanup modeline
(require-package 'diminish)
(eval-after-load "paredit" '(diminish 'paredit-mode))
(eval-after-load "smartparens" '(diminish 'smartparens-mode))

(provide 'init-appearance)
