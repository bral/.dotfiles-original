(setq ring-bell-function 'ignore
      font-lock-maximum-decoration t
      color-theme-is-global t
      truncate-partial-width-windows nil)

;; Highlight current line
(global-hl-line-mode 1)

;; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

(setq-default cursor-type 'bar)

;; Setup GUI mode
(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (blink-cursor-mode -1))

(setq indicate-empty-lines t)

;; Make zooming affect frame instead of buffers
(require-package 'zoom-frm)

;; Show keystrokes in progress
(setq echo-keystrokes 0.1)

;; Don't defer screen updates when performing operations
(setq redisplay-dont-pause t)

;; Cleanup modeline
(require-package 'diminish)
(eval-after-load "paredit" '(diminish 'paredit-mode))
(eval-after-load "smartparens" '(diminish 'smartparens-mode))
(eval-after-load "yasnippet" '(diminish 'yas-minor-mode))
(eval-after-load "skewer-mode" '(diminish 'skewer-mode))
(eval-after-load "skewer-css" '(diminish 'skewer-css-mode))
(eval-after-load "skewer-html" '(diminish 'skewer-html-mode))

(defmacro rename-modeline (package-name mode new-name)
  `(eval-after-load ,package-name
     '(defadvice ,mode (after rename-modeline activate)
        (setq mode-name ,new-name))))

(rename-modeline "js2-mode" js2-mode "JS2")
(rename-modeline "clojure-mode" clojure-mode "Clj")

;; Dim parenthesis
(require-package 'paren-face)
(global-paren-face-mode)

(provide 'init-appearance)
