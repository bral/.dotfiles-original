(defvar mac-mode-pre-extensions
  '(
    redo+
    mac-key-mode
    ))

(defvar mac-mode-post-extensions '())

(defun mac-mode/init-redo+ ()
  (use-package redo+))

(defun mac-mode/init-mac-key-mode ()
  (use-package mac-key-mode))
