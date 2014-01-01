;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen
(setq inhibit-startup-message t)

;; Set up load path
(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path (expand-file-name "init" user-emacs-directory))

(defconst *spell-check-support-enabled* nil)
(defconst *is-a-mac* (eq system-type 'darwin))

;; Bootstrap
(require 'init-utils)
(require 'init-elpa)
(require 'init-exec-path)
(require 'init-custom)
(when *is-a-mac*
  (require 'init-mac))

;; History and backup
(require 'init-undohist)
(require 'init-backup)

;; Bindings
(require 'init-bindings)
(require 'init-moveline)

;; Appearance
(require 'init-themes)
(require 'init-maxframe)
(require 'init-uniquify)
(require 'init-appearance)

;; Misc
(require 'init-ido)
(require 'init-places)
(require 'init-flycheck)
(require 'init-hippie-expand)
;; (require 'init-autocomplete)
(require 'init-windows)
(require 'init-sessions)
(require 'init-mmm)

;; Editing
(require 'init-parens)
(require 'init-multicursor)
(require 'init-undo-tree)
(require 'init-whitespace)
(require 'init-wholeline)
(require 'init-editing)

;; Source control
(require 'init-git)

;; Languages
(require 'init-css)
(require 'init-elisp)
(require 'init-erlang)
(require 'init-jade)
(require 'init-javascript)
(require 'init-markdown)
(require 'init-mode-map)
(require 'init-stylus)

;; Get settings for currently logged in user
(setq user-settings-dir (concat user-emacs-directory "users/" user-login-name))
(when (file-exists-p user-settings-dir)
  (add-to-list 'load-path user-settings-dir)
  (mapc 'load (directory-files user-settings-dir nil "^[^#].*el$")))

(provide 'init)
