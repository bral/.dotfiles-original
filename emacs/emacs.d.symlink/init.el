;;;

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;; todo measure startup time

(defconst *spell-check-support-enabled* nil)

;; Bootstrap
(require 'init-elpa)
(require 'init-exec-path)
(require 'init-backup)

;; Themes
(require 'init-themes)
(require 'init-ui)

;; Languages
(require 'init-erlang)

;; Move lines with M-p and M-n
(require 'init-moveline)
