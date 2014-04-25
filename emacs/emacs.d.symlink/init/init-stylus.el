(require-package 'stylus-mode)

(require-package 'sws-mode)

(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))

(defun stylus-indent-line ()
  "Indents current line"
  (interactive)
  (if (eq this-command 'indent-for-tab-command)
    (if mark-active
        (sws-indent-region (region-beginning) (region-end))
      (if (sws-at-bot-p)
          (sws-do-indent-line)
        (sws-point-to-bot)))
    (indent-to (+ (sws-previous-indentation) sws-tab-width)))

; (defun stylus-tab-properly ()
;   (interactive)
;   (let ((yas-fallback-behavior 'return-nil))
;     (unless (yas-expand)
;       (sws-indent-line)
;       )))

(define-key stylus-mode-map (kbd "TAB") 'stylus-indent-line)

;; TOOD add flymake support

(provide 'init-stylus)
