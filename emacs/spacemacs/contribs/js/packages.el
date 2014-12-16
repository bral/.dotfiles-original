(defvar js-packages
  '(
    js2-mode
    json-mode
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defun js/init-json-mode ()
  (use-package json-mode
    :defer t
    :init
    (add-hook 'json-mode-hook (lambda () (setq js-indent-level 2)))))

(defun js/init-js2-mode ()
  (use-package js2-mode
    :defer t
    :config
    (progn

      (setq-default js2-global-externs '(
        "node" ;; node-webkit
        "phantom" ;; phantomjs
        "yield" ;; es6
        "setTimeout" "clearTimeout" "setInterval" "clearInterval" "console" "JSON" "global" ;; javascript
        "module" "require" "exports" ;; commonjs
        "__filename" "__dirname" "process" "Buffer" ;; node
        "location" "window" "history" ;; browser
        "it" "describe" "before" "after" "beforeEach" "afterEach" ;; mocha
        "suite" "test" "setup" "teardown" ;; mocha tdd
        "expect" ;; jasmine
        "inject" ;; angular-mock
        "angular" ;; angular
        "Meteor" "Template" "Session" ;; meteor
        "React" ;; react
        "chrome" ;; chrome
        ))

      (setq-default js2-indent-level 2)
      (setq-default js2-basic-offset 2)
      (setq-default js2-bounce-indent-p nil))
      (setq-default js2-allow-rhino-new-expr-initializer nil)
      (setq-default js2-auto-indent-p nil)
      (setq-default js2-enter-indents-newline nil)

      ;; Skip semi-colon if one is present
      (define-key js2-mode-map (kbd ";")
        (lambda ()
          (interactive)
          (if (looking-at ";")
              (forward-char)
            (funcall 'self-insert-command 1))))

      ;; Use lambda for anonymous functions
      (font-lock-add-keywords
      'js2-mode `(("\\(function\\)("
                    (0 (progn (compose-region (match-beginning 1)
                                              (match-end 1) "\u0192")
                              nil)))))

      ;; Use right arrow for return in one-line functions
      (font-lock-add-keywords
      'js2-mode `(("function *([^)]*) *{ *\\(return\\) "
                    (0 (progn (compose-region (match-beginning 1)
                                              (match-end 1) "\u2190")
                              nil)))))

      ;; Enable yasnippet
      (setq-default yas-minor-mode t)))
