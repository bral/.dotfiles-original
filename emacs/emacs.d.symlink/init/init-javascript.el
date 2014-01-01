(require-package 'json-mode)
(when (>= emacs-major-version 24)
  (require-package 'js2-mode)
  (require-package 'ac-js2))
(require-package 'js-comint)
(require-package 'rainbow-delimiters)

;; Configure mode
(defcustom preferred-javascript-mode
  (first (remove-if-not #'fboundp '(js2-mode js-mode)))
  "Javascript mode to use for .js files."
  :type 'symbol
  :group 'programming
  :options '(js2-mode js-mode))

(setq js-indent-level 2)
(setq js2-use-font-lock-faces t
      js2-mode-must-byte-compile nil
      js2-basic-offset 2
      js2-indent-on-enter-key t
      js2-auto-indent-p t
      js2-bounce-indent-p nil)

(after-load 'js2-mode
  (js2-imenu-extras-setup))

(add-to-list 'interpreter-mode-alist (cons "node" preferred-javascript-mode))

;; Set the name
(after-load 'js2-mode
  (add-hook 'js2-mode-hook '(lambda () (setq mode-name "JS"))))

;; Key bindings
(after-load 'js2-mode
  (define-key js2-mode-map (kbd "TAB") 'indent-for-tab-command))

;; Configure the runtime
;; TODO use node instead

(provide 'init-javascript)
