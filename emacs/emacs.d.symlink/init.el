;;;

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;; todo measure startup time

(defconst *spell-check-support-enabled* nil)

;; Bootstrap
(require 'init-elpa)
(require 'init-exec-path)

;; Themes
(require 'init-themes)

;; Move lines with M-p and M-n
(require 'init-moveline)
