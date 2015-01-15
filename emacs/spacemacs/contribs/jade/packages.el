(defvar jade-packages
  '(
    jade-mode
    ))

(defun jade/init-jade-mode ()
  (use-package jade-mode
    :defer t
    :config
    (add-hook 'jade-mode
              (lambda ()
                (adaptive-wrap-prefix-mode)))))
