(defmacro after-load (feature &rest body)
  "After FEATURE is loaded, evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,feature
     '(progn ,@body)))

;; Shorthand for interactive lambdas
(defmacro λ (&rest body)
  `(lambda ()
     (interactive)
     ,@body))
(global-set-key (kbd "A-l") (λ (insert "\u03bb")))

;; Save anyway
(defun save-unmodified-buffer ()
  "This saves the buffer, even when unmodified. Useful for file watchers."
  (λ (set-buffer-modified-p t)
     (save-buffer)))

(provide 'init-utils)
