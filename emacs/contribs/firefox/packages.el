(defvar firefox-packages
  '(
    moz
    moz-controller
    ))

(defun firefox/init-moz ()
  (use-package moz))

(defun firefox/init-moz-controller ()
  (use-package moz-controller
    :init
    (autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

    (add-hook 'javascript-mode-hook 'javascript-custom-setup)
    (defun javascript-custom-setup ()
      (moz-minor-mode 1))))
