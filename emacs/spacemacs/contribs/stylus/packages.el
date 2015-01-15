(defvar stylus-packages
  '(
    stylus-mode
    ))

(defun stylus/init-stylus-mode ()
  (use-package stylus-mode
    :init
    (progn
      (adaptive-wrap-prefix-mode))))
    
