(defvar bindings-pre-extensions
  '(
    use-package
    ))

(defvar bindings-post-extensions
  '(
    mac-key-mode
    elscreen
    ))

(defun bindings/init-use-package ()
  (require 'use-package))

(defun bindings/init-mac-key-mode ()
  (use-package mac-key-mode
    :init
    (progn
      ;; Default keysets
      (mac-key-mode 1)
      (setq mac-command-modifier 'alt)
      (setq mac-option-modifier 'meta)
      )))

(defun bindings/init-elscreen ()
  (use-package elscreen
    :init
    (progn
      (elscreen-start))))
