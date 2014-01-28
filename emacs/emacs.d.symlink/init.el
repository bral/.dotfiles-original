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
(require 'init-custom-generate)

;; Platform
(when *is-a-mac*
  (require 'init-mac))

;; Recovery
(require 'init-undohist)
(require 'init-backup)
(require 'init-places)
;; TODO stop this from asking to save desktop on quit
;; (require 'init-sessions)

;; Bindings
(require 'init-caps-lock)
(require 'init-bindings)
(require 'init-moveline)

;; Interface
(require 'init-themes)
(require 'init-maxframe)
(require 'init-uniquify)
(require 'init-linenumbers)
(require 'init-appearance)
(require 'init-urls)
(require 'init-ido)
(require 'init-highlight-escape-sequences)

;; Misc
;; (require 'init-flycheck)
;; (require 'init-autocomplete)
(require 'init-hippie-expand)
(require 'init-mmm)
(require 'init-restclient)
(require 'init-dash)

;; Shells
(require 'init-eshell)
(require 'init-shell)
(require 'init-quickrun)

;; Layout
(require 'init-frame-manage)
(require 'init-window-manage)
(require 'init-golden-ratio)
(require 'init-screen)

;; Editing
;; (require 'init-parens)
(require 'init-multicursor)
(require 'init-undo-tree)
(require 'init-whitespace)
(require 'init-wholeline)
(require 'init-editing)
(require 'init-move-text)
;; (require 'init-smartparens)

;; Snippets
(require 'init-yasnippet)
(require 'init-yasnippet-helpers)

;; Projects
;; (require 'init-git)
(require 'init-project)

;; Languages
(require 'init-json)
(require 'init-javascript)
(require 'init-css)
(require 'init-elisp)
(require 'init-erlang)
(require 'init-jade)
(require 'init-markdown)
(require 'init-stylus)
(require 'init-yaml)
(require 'init-rework)

;; Autoload
(require 'init-autoload)

;; Mode-mappings
(require 'init-mode-map)

;; Server
(require 'server)
(unless (server-running-p)
  (server-start))

;; Locales
(require 'init-locales)

;; Local
(require 'init-local)

(provide 'init)
