(defvar bindings-pre-extensions
  '(
    redo+
    mac-key-mode
    ))

(defvar bindings-post-extensions '(elscreen))

(defun bindings/init-elscreen ()
  (use-package evil)
  (use-package mac-key)
  (use-package elscreen)

  (elscreen-start)

  (define-key mac-key-mode-map [(alt t)] 'elscreen-create)
  (define-key mac-key-mode-map [(alt })] 'elscreen-next)
  (define-key mac-key-mode-map [(alt {)] 'elscreen-previous)
  (define-key mac-key-mode-map [(alt w)] 'elscreen-kill)

  (use-package zoom-frm)

  (define-key mac-key-mode-map [(alt -)] 'zoom-frm-out)
  (define-key mac-key-mode-map [(alt =)] 'zoom-frm-in)

  (use-package windmove)

  (setq caps-lock-modifier "A-C-M")
  (defun caps-lock-bind (key)
    (kbd (concat caps-lock-modifier "-" key)))

  (global-set-key (caps-lock-bind "h") 'windmove-left)
  (global-set-key (caps-lock-bind "j") 'windmove-down)
  (global-set-key (caps-lock-bind "k") 'windmove-up)
  (global-set-key (caps-lock-bind "l") 'windmove-right)

  (use-package projectile)
  )
