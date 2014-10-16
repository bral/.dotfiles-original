;;; styl-mode.el --- Major mode for editing YAML files

;; Copyright (C) 2014 Michael Vanasse

;; Author: Michael Vanasse <mail@mndvns.com>
;; Keywords: styl whitespace
;; Version: 0.0.1

;; This file is not part of Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;;  A work in progress. Pull request.

;;; Installation:

;; To install, just drop this file into a directory in your
;; `load-path' and (optionally) byte-compile it.  To automatically
;; handle files ending in '.styl', add something like:
;;
;;    (require 'styl-mode)
;;    (add-to-list 'auto-mode-alist '("\\.styl$" . styl-mode))
;;
;; to your .emacs file.

;;; Code:

(require 'font-lock)

(eval-when-compile (require 'cl))

;; User defined variables

;;;###autoload
(defgroup styl nil
  "Support for whitespace significant languages"
  :group 'languages
  :prefix "styl-")

(defgroup styl-faces nil
  "Fontification colors."
  :link '(custom-group-link :tag "Font Lock Faces group" font-lock-faces)
  :prefix "styl-"
  :group 'styl)

(defcustom styl-tab-width 2
  "The tab width to use when indenting."
  :type 'integer
  :group 'styl
  :safe 'integerp)

(defcustom styl-indent-tabs-mode nil
  "Indentation can insert tabs if this is t."
  :group 'styl
  :type 'boolean)

(defconst styl-mode-version"0.0.1" "Version of `styl-mode'.")

;;
;; Syntax table
;;

(defvar styl-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?\( "()  " st)
    (modify-syntax-entry ?\) ")(  " st)
    (modify-syntax-entry ?\[ "(]  " st)
    (modify-syntax-entry ?\] ")[  " st)
    (modify-syntax-entry ?{  "(}  " st)
    (modify-syntax-entry ?}  "){  " st)

    (modify-syntax-entry ?/ ". 124" st)
    (modify-syntax-entry ?* ". 23b" st)
    (modify-syntax-entry ?\n ">" st)

    (dolist (ch '(?, ?: ?! ??))
      (modify-syntax-entry ch ".   " st))
    (modify-syntax-entry ?\" "\"\"   " st)
    (modify-syntax-entry ?'  "\"'   " st)
    (modify-syntax-entry ?`  "$   " st)
    (modify-syntax-entry ?@  "'   " st)
    (modify-syntax-entry ?\\ "\\   " st)
    st)
  "Syntax table in use in `styl-mode' buffers.")

(defvar styl-mode-abbrev-table nil)
(define-abbrev-table 'styl-mode-abbrev-table ())

;;
;; Face
;;

(defface styl-font-lock-bold-face
  '((t :inherit bold))
  "Font Lock mode face used to highlight interpolation in Styl regexps."
  :group 'styl-faces)


(defface styl-font-lock-shadow-face
  '((((class color grayscale) (min-colors 88) (background light))
     :foreground "grey30"
     :weight semi-bold)
    (((class color grayscale) (min-colors 88) (background dark))
     :foreground "grey70"
     :weight semi-bold)
    (t :inherit shadow))
  "Font Lock mode face used to highlight this/it/that in STYL regexps."
  :group 'styl-faces)

;; Utility

(defun styl--regexp-from-symbols (sequence)
  (concat "\\_<" (regexp-opt (mapcar #'symbol-name sequence) t) "\\>"))

(defun styl--join-string (strings separator)
  (mapconcat #'identity strings separator))

;;
;; Search based highlighting
;;

(defvar styl-keywords-regexp
  (let* ((js-keywords    [break catch class continue delete else extends
                          finally for if loop new return
                          super switch throw try until while])
         (cs-keywords    [by of own then unless when])
         (ls-keywords    [fallthrough otherwise from til to])
         (js/cs-reserved [case const debugger default do enum export
                          function import let native var void with
                          __extends __hasProp])
	(keywords (vconcat js-keywords cs-keywords ls-keywords js/cs-reserved)))
    (styl--regexp-from-symbols keywords))
  "Regular expression to match ordinary keywords of Styl.")

(defvar styl-boolean-operators-regexp
  (styl--regexp-from-symbols [and in is isnt not or])
  "Regular expression to match boolean operators.")

(defvar styl-builtins-regexp
  (styl--regexp-from-symbols [instanceof typeof])
  "Regular expression to match 'instanceof' or 'typeof'.")

(defvar styl-context-regexp
  (styl--regexp-from-symbols [this it that])
  "Regular expression to match 'this', 'it' or 'that'.")

(defvar styl-boolean-regexp
  (styl--regexp-from-symbols [true false yes no on off null undefined])
  "Regular expression to match booleans themselves.")

(defvar styl-property-regexp "\\(\\w+\\)\\s-*:"
  "Regular expression to match property names.")

(defvar styl-negate-regexp "\\(\\w+\\s-*:[:=]\\|@@\\w*\\)"
  "Regular expression to negate highlighting.")

(defvar styl-instance-regexp "\\(@\\w+\\)"
  "Regular expression to match instance variables.")

(defvar styl-function-name-regexp
  (let* ((param     "\\s-*\\(?:\\w\\|\\.\\)+\\s-*")
	 (default   "\\(?:\\(?:[:=?]\\|||\\)\\s-*\\|\\s-+or\\s-+\\)[^,\)]+?")
	 (arg       (concat param "\\(?:" default "\\)?"))
	 (args      (concat arg "\\(?:," arg "\\)*"))
	 (arrow     "\\(?:--?\\|~~?\\)>")
	 (anon-func (concat "!?\\s-*\\(?:(" args ")\\)?\\s-*" arrow))
	 (func-name "\\(?1:\\w+\\)")
	 ;; func = [(args)] ->
         (func-def1 (concat "\\_<" func-name "\\s-*[:=]\\s-*" anon-func))
	 ;; function func [args] [(then|=>) ...]
         (func-def2 (concat "^\\s-*[!~]?\\s-*function\\s-+" func-name)))
    (format "\\(?:%s\\|%s\\)" func-def1 func-def2))
  "Regular expression to match function names.")

(defvar styl-class-name-regexp
  "\\_<class\\s-+\\(?:exports\.\\)?\\(\\w+\\)"
  "Regular expression to match class names.")

(defun styl-interpolation-matcher (bound)
  "Function to match interpolation."
  (catch 'found
    (while (re-search-forward
			"\\(\/\\(?:{\\(?2:.*?\\)\\}\\|\\w+\\)\\)"
			bound t)
      (let ((face         (styl--get-face   (1- (point))))
            (syntax-class (styl--get-syntax (match-beginning 1))))
        (when (styl--interpolatable-p face syntax-class)
	  (throw 'found t))))))

(defun styl-comment-inside-heregex-matcher (bound)
  "Function to match comment inside heregex."
  (catch 'found
    (while (re-search-forward "\\(\/{2}\\s-.*$\\)" bound t)
      (let ((face (styl--get-face (1- (point)))))
        (when (memq styl-heregex-face face)
	  (throw 'found t))))))

(defun styl--interpolatable-p (face syntax-class)
  (and (styl--interpolatable-face-p         face)
       (styl--interpolatable-syntax-class-p syntax-class)))

(defvar styl-interpolatable-faces
  '(font-lock-string-face font-lock-constant-face))

(defun styl--interpolatable-face-p (face)
  (intersection face styl-interpolatable-faces))

(defvar styl-interpolatable-syntax-classes '(6))

(defun styl--interpolatable-syntax-class-p (syntax-class)
  (not (and syntax-class
	    (memq syntax-class styl-interpolatable-syntax-classes))))

(defvar styl-heregex-face 'font-lock-constant-face)

(defun styl--get-face (point)
  (let ((face (get-text-property point 'face)))
    (if (listp face) face (list face))))

(defun styl--get-syntax (point)
  (syntax-class (get-text-property point 'syntax-table)))

;;
;; Font lock keywords
;;

(defconst styl-font-lock-keywords-1
  `((,styl-negate-regexp         1 font-lock-negation-char-face)
    (,styl-instance-regexp       1 font-lock-variable-name-face)
    (,styl-function-name-regexp  1 font-lock-function-name-face)
    (,styl-class-name-regexp     1 font-lock-type-face)
    (,styl-property-regexp       1 font-lock-type-face)
    (,styl-boolean-regexp        1 font-lock-constant-face)
    (,styl-keywords-regexp       1 font-lock-keyword-face)))

(defconst styl-font-lock-keywords-2
  (append styl-font-lock-keywords-1
          `((,styl-boolean-operators-regexp 1 font-lock-builtin-face)
            (,styl-builtins-regexp          1 font-lock-builtin-face)
            (,styl-context-regexp
             (1 'styl-font-lock-shadow-face))
            (styl-interpolation-matcher
             (1 'styl-font-lock-bold-face prepend)
             (2 font-lock-string-face t t))
	    (styl-comment-inside-heregex-matcher
	     (1 font-lock-comment-face prepend t)))))

(defvar styl-font-lock-keywords styl-font-lock-keywords-1
  "Default `font-lock-keywords' of Styl mode.")

;;
;; Indentation
;;

(defsubst styl-insert-spaces (count)
  (if styl-indent-tabs-mode
      (insert-char (string-to-char "\t")  (floor count styl-tab-width))
    (insert-char ?  count)))

(defun styl-indent-line ()
  "Indent current line as StylScript."
  (interactive)
  (if (= (point) (line-beginning-position))
      (styl-insert-spaces styl-tab-width)
    (save-excursion
      (let ((prev-indent (styl-previous-indent)))
        ;; Shift one column to the left
        (beginning-of-line)
        (styl-insert-spaces styl-tab-width)

        (when (= (point-at-bol) (point))
          (forward-char styl-tab-width))

        ;; We're too far, remove all indentation.
        (when (> (- (current-indentation) prev-indent) styl-tab-width)
          (backward-to-indentation 0)
          (delete-region (point-at-bol) (point)))))))

(defun styl-previous-indent ()
  "Return the indentation level of the previous non-blank line."
  (save-excursion
    (forward-line -1)
    (if (bobp)
        0
      (while (and (looking-at "^[ \t]*$") (not (bobp)))
        (forward-line -1))
      (current-indentation))))

;;
;; Imenu support
;;

(defvar styl-imenu-generic-expression
  `((nil ,styl-function-name-regexp 1))
  "Imenu generic expression for Styl mode.")

;;
;; Commands
;;

(defvar styl-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "TAB") 'styl-indent-line)
    map)
  "Keymap used in Styl mode.")

;;
;; Syntax propertize
;;

(defconst styl--conflicting-syntax-classes
  (let ((string-quote   7)
	(escape         9)
	(comment-start 11))
    (list comment-start string-quote escape))
  "List of syntax classes which can conflict with syntax-table property.")

(defun styl--put-syntax (beg end syntax)
  "Set the syntax property on the current buffer to SYNTAX between BEG and END.
SYNTAX is a string which `string-to-syntax' accepts."
  (put-text-property beg end 'syntax-table (string-to-syntax syntax)))

(defun styl--escape-syntax (beg end subst)
  (loop for i from beg to end
	do (let ((class (syntax-class (syntax-after i))))
	     (when (memq class styl--conflicting-syntax-classes)
	       (styl--put-syntax i (1+ i) subst)))))

(defun styl--put-enclosing-syntax (beg end syntax &optional subst)
  (styl--put-syntax beg (1+ beg) syntax)
  (when subst
    (styl--escape-syntax (1+ beg) (1- end) subst))
  (styl--put-syntax (1- end) end syntax))

(defun styl--put-syntax-multiline (beg end syntax &optional subst)
  (put-text-property beg end 'syntax-multiline    t)
  (put-text-property beg end 'font-lock-multiline t)
  (styl--put-enclosing-syntax beg end syntax subst))

(defun styl--multiline-rule (open close syntax &optional subst)
  `(,(format "\\(%s[[:ascii:]]*?%s\\)" open (or close open))
    (1 (ignore
        (styl--put-syntax-multiline
         (match-beginning 1) (match-end 1) ,syntax ,subst)))))

(defvar styl--unclosed-positions nil
  "Unclosed literals and their positions.")

(defun styl--make-unclosed-positions ()
  (let ((tbl (make-hash-table :size 11)))
    (dolist (syntax styl-complex-syntax)
      (puthash syntax nil tbl))
    tbl))

(defconst styl-complex-syntax '(\'\'\' \"\"\" <\\\[ //)
  "List of symbols whose names are complex syntax elements.
Complex syntax elements are heredocument, string list and heregexp.")

(defun styl--make-syntax-propertize-function ()
  "Return a function used for highlighting codes syntactically."
  ;; prepare rules
  (let ((skip-comment '("\\(\/\\s<.*\\)$" (1 (ignore))))
	(heredoc1     (styl--multiline-rule "'''"    nil "\"" "'"))
	(heredoc2     (styl--multiline-rule "\"\"\"" nil "\"" "_"))
	(skip-string  '("\\([^\"'\\]\\s\"\\S\"+?\\s\"\\)" (1 (ignore))))
	(string-list  (styl--multiline-rule "<\\[" "\\]>" "|")))
    ;; embed rules before calling macro
    (eval `(syntax-propertize-rules
	    ,skip-comment
	    ,heredoc1
	    ,heredoc2
	    ,skip-string
	    ,string-list

	    ;; /regular-expression/
	    ((concat "\\(?:^\\|\\W\\)"
		     "\\(/\\)"
		     "\\(?:\\\\.\\|\\[\\(?:\\\\.\\|.\\)+\\]\\|[^*/\n]\\)"
		     "\\(?:\\\\.\\|\\[\\(?:\\\\.\\|.\\)+\\]\\|[^/\n]\\)*"
		     "\\(/\\)"
		     "[gimy$?]\\{0,4\\}")
	     (1 "\"/") (2 "\"/"))

	    ;; \string
	    ("\\(\\\\[^[:space:]\n][^]}\),;[:space:]\n]*\\)"
	     (1 (ignore
	    	 (styl--put-enclosing-syntax
	    	  (match-beginning 1) (match-end 1) "|" "'"))))

	    ;; unclosed multiline literals
	    ((let ((complex (mapcar #'symbol-name styl-complex-syntax)))
	       (concat "\\(" (styl--join-string complex "\\|") "\\)"))
	     (1 (ignore
	    	 (puthash (intern-soft (match-string 1)) (match-beginning 1)
	    		  styl--unclosed-positions))))
	    ))))

(defconst styl-syntax-propertize-function
  (styl--make-syntax-propertize-function))

(defvar styl-syntax-propertize-extend-region-functions
  (append
   '(styl-syntax-propertize-extend-region-function)
   syntax-propertize-extend-region-functions))

(defun styl-syntax-propertize-extend-region-function (start end)
  "Fix the range of syntax propertization from START to END."
  (let* ((new-start start)
         (new-end end)
         (min-unclosed (styl-minimum-unclosed)))
    (when min-unclosed
      (save-excursion
	(goto-char (cdr min-unclosed))
	(setq new-start (line-beginning-position)))
      (styl--clear-unclosed-positions))
    (cons new-start new-end)))

(defun styl-minimum-unclosed ()
  "Return the position where the first unclosed syntax appears."
  (let (kv-alist)
    (maphash #'(lambda (k v) (when v (push (cons k v) kv-alist)))
	     styl--unclosed-positions)
    (when kv-alist
      (car (sort kv-alist #'(lambda (a b) (< (cdr a) (cdr b))))))))

(defun styl--clear-unclosed-positions ()
  (maphash #'(lambda (k v) (puthash k nil styl--unclosed-positions))
	   styl--unclosed-positions))

(defun styl-font-lock-extend-region-function ()
  (let ((min-unclosed (styl-minimum-unclosed)))
    (when (and min-unclosed (< (cdr min-unclosed) font-lock-beg))
      (setq font-lock-beg (cdr min-unclosed)))))

(defvar styl-font-lock-extend-region-functions
  (append
   '(styl-font-lock-extend-region-function)
   font-lock-extend-region-functions))

(defun styl-syntactic-face-function (state)
  "Return one of font-lock's basic face according to the parser's STATE.
STATE is a return value of `syntax-ppss'."
  (case (styl--string-state state)
    ((nil) 'font-lock-comment-face)
    ((?/)  'font-lock-constant-face)
    (t     'font-lock-string-face)))

(defun styl--string-state (state) (nth 3 state))

;;
;; Setup
;;

(defun styl-mode-variables ()
  "Setup buffer-local variables for `styl-mode'."
  ;; Syntax table
  (set-syntax-table styl-mode-syntax-table)
  ;; Abbrev
  (setq local-abbrev-table styl-mode-abbrev-table)
  ;; Comment
  (set (make-local-variable 'comment-start) "/")
  (set (make-local-variable 'comment-add) 1)
  ;; Imenu
  (setq imenu-case-fold-search t)
  (setq imenu-syntax-alist '(("-_$" . "w")))
  (setq imenu-generic-expression styl-imenu-generic-expression)
  ;; Font-lock
  (set (make-local-variable 'font-lock-defaults)
       '((styl-font-lock-keywords
	  styl-font-lock-keywords-1 styl-font-lock-keywords-2)
	 nil nil (("-_$" . "w")) nil
	 (font-lock-syntactic-face-function
	  . styl-syntactic-face-function)
	 (parse-sexp-lookup-properties . t)))
  ;; Syntactic fontification
  (set (make-local-variable 'styl--unclosed-positions)
       (styl--make-unclosed-positions))

  (set (make-local-variable 'syntax-propertize-extend-region-functions)
       styl-syntax-propertize-extend-region-functions)
  (set (make-local-variable 'font-lock-extend-region-functions)
       styl-font-lock-extend-region-functions)
  (set (make-local-variable 'syntax-propertize-function)
       styl-syntax-propertize-function))

;;;###autoload
(define-derived-mode styl-mode prog-mode "Styl"
  "Major mode for editing Styl code.

Commands:

\\{styl-mode-map}"
  (styl-mode-variables))

;;
;; Customize variables
;;

(defcustom styl-mode-hook nil
  "Normal hook run when entering `styl-mode'.
See `run-hooks'."
  :type 'hook
  :group 'styl)

(defcustom styl-program-name "styl"
  "The command to evaluate Styl code."
  :type 'string
  :group 'styl)

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.styl\\'" . styl-mode))

;;;###compile in emacs

(defcustom styl-args-compile '("")
  "The arguments to pass to `styl-command' to compile a file."
  :type 'list
  :group 'styl)

(defcustom styl-command "stylus"
  "The Styl command used for evaluating code."
  :type 'string
  :group 'styl)

(defcustom styl-compiled-buffer-name "*stylus-compiled*"
  "The name of the scratch buffer used for compiled Styl."
  :type 'string
  :group 'styl)

(defun styl-compile-region (start end)
  "Compiles a region and displays the JavaScript in a buffer called
`styl-compiled-buffer-name'."
  (interactive "r")

  (let ((buffer (get-buffer styl-compiled-buffer-name)))
    (when buffer
      (with-current-buffer buffer
        (erase-buffer))))

  (apply (apply-partially 'call-process-region start end
                          styl-command nil
                          (get-buffer-create styl-compiled-buffer-name)
                          nil)
         (append (list "--print")))

  (let ((buffer (get-buffer styl-compiled-buffer-name)))
    (display-buffer buffer)
    (with-current-buffer buffer
      (let ((buffer-file-name "tmp.css")) (set-auto-mode)))))

(defun styl-compile-buffer ()
  "Compiles the current buffer and displays the JavaScript in a buffer
called `styl-compiled-buffer-name'."
  (interactive)
  (save-excursion
    (styl-compile-region (point-min) (point-max))))


(defun styl-mode-version ()
  "Diplay version of `styl-mode'."
  (interactive)
  (message "styl-mode %s" styl-mode-version)
  styl-mode-version)

;;;###autoload
(provide 'styl-mode)

;;; styl-mode.el ends here
