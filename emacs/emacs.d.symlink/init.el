;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq inhibit-startup-message t)

(add-to-list 'load-path (expand-file-name "init" user-emacs-directory))

(defconst *spell-check-support-enabled* nil)
(defconst *is-a-mac* (eq system-type 'darwin))

;; Bootstrap
(require 'init-utils)
(require 'init-elpa)
(require 'init-exec-path)
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

;; Languages
(require 'init-mode-map)
(require 'init-erlang)

;; Misc
(require 'init-ido)
(require 'init-places)
(require 'init-flycheck)
(require 'init-hippie-expand)
;; (require 'init-autocomplete)
(require 'init-windows)
(require 'init-sessions)
(require 'init-mmm)

(require 'init-multicursor)
(require 'init-undo-tree)
(require 'init-whitespace)
(require 'init-editing)

(provide 'init)
