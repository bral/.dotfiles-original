(defvar bindings-packages
  '(
    windmove
    zoom-frm
    elscreen
    ))

(defun bindings/init-elscreen ()
  (use-package elscreen
    :init
    (elscreen-start)))
