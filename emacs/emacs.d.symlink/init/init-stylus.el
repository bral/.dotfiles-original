(require-package 'sws-mode)

(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))

;; TOOD add flymake support

(provide 'init-stylus)
