;;;

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;; todo measure startup time

(defconst *spell-check-support-enabled* nil)

(require 'init-elpa)

;; Move lines with M-p and M-n
(require 'init-moveline)
