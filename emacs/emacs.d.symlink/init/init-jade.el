(require-package 'jade-mode)

(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;; TODO add flymake support

(provide 'init-jade)
