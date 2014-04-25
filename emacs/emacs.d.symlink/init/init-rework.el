;;; rework-mode.el --- Major mode for editing rework (.css|.styl|*) files
;;;
;;; URL: https://github.com/mndvns/rework-mode
;;; Author: Michael Vanasse
;;; Package-Requires: ((sws-mode "0"))
;;;
(require-package 'stylus-mode)

(require 'font-lock)
(require 'sws-mode)

(defun rework-debug (string &rest args)
  "Prints a debug message"
  (apply 'message (append (list string) args)))

(defmacro rework-line-as-string ()
  "Returns the current line as a string."
  `(buffer-substring (point-at-bol) (point-at-eol)))

(defun rework-empty-line-p ()
  "If line is empty or not."
  (= (point-at-eol) (point-at-bol)))

(defun rework-blank-line-p ()
  "If line contains only spaces."
  (string-match-p "^[ ]*$" (rework-line-as-string)))

(defconst rework-colours
  (eval-when-compile
    (regexp-opt
     '("black" "silver" "gray" "white" "maroon" "red"
       "purple" "fuchsia" "green" "lime" "olive" "yellow" "navy"
       "blue" "teal" "aqua")))
  "Rework keywords.")

(defconst rework-keywords
  (eval-when-compile
    (regexp-opt
     '("return" "if" "else" "unless" "for" "in" "true" "false")))
  "Rework keywords.")

(defvar rework-font-lock-keywords
  `(
    (,"\\(::?\\(require\\|content\\|locals\\|exports\\)\\)*" . font-lock-preprocessor-face)
    (,"^[ {2,}]+[a-z0-9_:\\-]+[ ]" 0 font-lock-variable-name-face)
    (,"\\(::?\\(root\\|nth-child\\|nth-last-child\\|nth-of-type\\|nth-last-of-type\\|first-child\\|last-child\\|first-of-type\\|last-of-type\\|only-child\\|only-of-type\\|empty\\|link\\|visited\\|active\\|hover\\|focus\\|target\\|lang\\|enabled\\|disabled\\|checked\\|not\\)\\)*" . font-lock-type-face) ;; pseudoSelectors
    (,(concat "[^_$-]?\\<\\(" rework-colours "\\)\\>[^_]?")
     0 font-lock-constant-face)
    (,(concat "[^_$/]?\\<\\(" rework-keywords "\\)\\>[^_]?")
     0 font-lock-keyword-face)
    (,"\\([.0-9]+:?\\(em\\|ex\\|px\\|mm\\|cm\\|in\\|pt\\|pc\\|deg\\|rad\\|grad\\|ms\\|s\\|Hz\\|kHz\\|rem\\|%\\)\\)" 0 font-lock-constant-face)
    (,"__\\w+" 0 font-lock-constant-face)
    (,"_/\\w+" 0 font-lock-constant-face)
    (,"%\\w+" 0 font-lock-keyword-face)
    (,"$\\w+" 0 font-lock-variable-name-face)
    ))

(defvar rework-syntax-table
  (let ((syntable (make-syntax-table)))
    (modify-syntax-entry ?\/ ". 124b" syntable)
    (modify-syntax-entry ?* ". 23" syntable)
    (modify-syntax-entry ?\n "> b" syntable)
    (modify-syntax-entry ?' "\"" syntable)
    syntable)
  "Syntax table for `rework-mode'.")

(defun rework-region-for-sexp ()
  "Selects the current sexp as the region"
  (interactive)
  (beginning-of-line)
  (let ((ci (current-indentation)))
    (push-mark nil nil t)
    (while (> (rework-next-line-indent) ci)
      (next-line)
      (end-of-line))))

(defvar rework-mode-map (make-sparse-keymap))
;;defer to sws-mode
;;(define-key rework-mode-map [S-tab] 'rework-unindent-line)

;; mode declaration
;;;###autoload
(define-derived-mode rework-mode sws-mode
  "Rework"
  "Major mode for editing rework node.js templates"
  (setq tab-width 2)

  (setq mode-name "Rework")
  (setq major-mode 'rework-mode)

  ;; syntax table
  (set-syntax-table rework-syntax-table)

  ;; highlight syntax
  (setq font-lock-defaults '(rework-font-lock-keywords))

  ;; comments
  (set (make-local-variable 'comment-start) "//")
  (set (make-local-variable 'comment-end) "")

  ;; default tab width
  (setq sws-tab-width 2)
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'sws-indent-line)
  (make-local-variable 'indent-region-function)

  (setq indent-region-function 'sws-indent-region)

  ;; keymap
  (use-local-map rework-mode-map))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.css$" . rework-mode))

(provide 'init-rework)
;;; rework-mode.el ends here
