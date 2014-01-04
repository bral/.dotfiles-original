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
(require 'init-urls)

;; Misc
(require 'init-ido)
(require 'init-places)
(require 'init-flycheck)
(require 'init-hippie-expand)
;; (require 'init-autocomplete)
(require 'init-windows)
(require 'init-sessions)
(require 'init-mmm)
(require 'init-restclient)
(require 'init-eshell)
(require 'init-dash)
(require 'init-golden-ratio)

;; Editing
(require 'init-parens)
(require 'init-multicursor)
(require 'init-undo-tree)
(require 'init-whitespace)
(require 'init-wholeline)
(require 'init-linenumbers)
(require 'init-editing)
(require 'init-yasnippet)
(require 'init-move-text)

;; Projects
(require 'init-git)
(require 'init-project)

;; Languages
(require 'init-css)
(require 'init-elisp)
(require 'init-erlang)
(require 'init-jade)
(require 'init-javascript)
(require 'init-markdown)
(require 'init-mode-map)
(require 'init-stylus)
(require 'init-yaml)

;; Server
(require 'server)
(unless (server-running-p)
  (server-start))

;; Locales
(require 'init-locales)

;; Local
(require 'init-local)

(provide 'init)
