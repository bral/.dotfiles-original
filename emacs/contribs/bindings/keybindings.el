(setq-default evil-escape-key-sequence (kbd "kj"))

(setq-default evil-shift-width 2)

;; Better line openings.
(defun open-line-below ()
  (interactive)
  (point-to-register 1)
  (end-of-line)
  (newline)
  (indent-for-tab-command)
  (beginning-of-line)
  (delete-trailing-whitespace)
  (jump-to-register 1))

(defun open-line-above ()
  (interactive)
  (point-to-register 1)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command)
  (beginning-of-line)
  (delete-trailing-whitespace)
  (jump-to-register 1))

(define-key evil-normal-state-map "[ " 'open-line-above)
(define-key evil-normal-state-map "] " 'open-line-below)

(define-key evil-insert-state-map (kbd "C-h") 'left-char)
(define-key evil-insert-state-map (kbd "C-j") 'next-line)
(define-key evil-insert-state-map (kbd "C-k") 'previous-line)
(define-key evil-insert-state-map (kbd "C-l") 'right-char)

(define-key mac-key-mode-map [(alt n)] 'new-frame)
(define-key mac-key-mode-map [(alt t)] 'elscreen-create)
(define-key mac-key-mode-map [(alt })] 'elscreen-next)
(define-key mac-key-mode-map [(alt {)] 'elscreen-previous)
(define-key mac-key-mode-map [(alt w)] 'elscreen-kill)

(define-key mac-key-mode-map [(alt -)] 'zoom-frm-out)
(define-key mac-key-mode-map [(alt =)] 'zoom-frm-in)

(setq caps-lock-modifier "A-C-M")
(defun caps-lock-bind (key)
  (kbd (concat caps-lock-modifier "-" key)))

(global-set-key (caps-lock-bind "h") 'windmove-left)
(global-set-key (caps-lock-bind "j") 'windmove-down)
(global-set-key (caps-lock-bind "k") 'windmove-up)
(global-set-key (caps-lock-bind "l") 'windmove-right)

; ;; JS

;; Project

(define-prefix-command (key-binding (kbd "A-p")))

(global-set-key (kbd "A-p P") 'projectile-mode)

(define-key projectile-mode-map (kbd "A-p d") 'projectile-find-dir)
(define-key projectile-mode-map (kbd "A-p p") 'projectile-switch-project)
(define-key projectile-mode-map (kbd "A-p f") 'projectile-find-file)
(define-key projectile-mode-map (kbd "A-p e") 'projectile-recentf)
(define-key projectile-mode-map (kbd "A-p r") 'projectile-replace)
(define-key projectile-mode-map (kbd "A-p R") 'projectile-regenerate-tags)
(define-key projectile-mode-map (kbd "A-p g") 'projectile-grep)

;; Configure mode
(defcustom preferred-javascript-mode
  (first (remove-if-not #'fboundp '(js2-mode js-mode)))
  "Javascript mode to use for .js files."
  :type 'symbol
  :group 'programming
  :options '(js2-mode js-mode))

(use-package json-mode
  :defer t
  )

(use-package js2-mode
  :diminish JS
  :init
    (use-package json)

    (setq-default js2-indent-level 2)
    (custom-set-variables
      '(js2-basic-offset 2)
      '(js2-bounce-indent-p nil))
    (setq-default js2-allow-rhino-new-expr-initializer nil)
    (setq-default js2-auto-indent-p nil)
    (setq-default js2-enter-indents-newline nil)
    (setq-default js2-global-externs '(
      ;; node-webkit
      "node"
      ;; phantomjs
      "phantom"
      ;; es6
      "yield"
      ;; javascript
      "setTimeout" "clearTimeout" "setInterval" "clearInterval" "console" "JSON" "global"
      ;; commonjs
      "module" "require" "exports"
      ;; node
      "__filename" "__dirname" "process" "Buffer"
      ;; browser
      "location" "window" "history"
      ;; mocha
      "it" "describe" "before" "after" "beforeEach" "afterEach"
      ;; mocha tdd
      "suite" "test" "setup" "teardown"
      ;; meteor
      "Meteor" "Template" "Session"
      ;; react
      "React"
      ;; angular
      "angular"
      ;; chrome
      "chrome"
      ))

  ;; Use lambda for anonymous functions
  (font-lock-add-keywords
   'js2-mode `(("\\(function\\) *?("
                (0 (progn (compose-region (match-beginning 1)
                                          (match-end 1) "\u0192")
                          nil)))))

  ;; Use right arrow for return in one-line functions
  (font-lock-add-keywords
   'js2-mode `(("function *([^)]*) *{ *\\(return\\) "
                (0 (progn (compose-region (match-beginning 1)
                                          (match-end 1) "\u2190")
                          nil)))))

  )
