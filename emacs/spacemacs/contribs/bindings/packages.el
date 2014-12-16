(defvar bindings-packages
  '(
    jade-mode
    projectile
    rust-mode
    windmove
    zoom-frm
    ))

(defun bindings/init-stylus-mode ()
  (use-package stylus-mode
    :init
    (progn
      (print "testing testing"))))

(defun bindings/init-rust-mode ()
  (use-package rust-mode))
     
(defun bindings/init-yasnippet ()
  (use-package yasnippet
    :commands (yas-minor-mode yas-minor-mode-on yas-global-mode)
    :init
    (progn
      (defun bindings/load-yasnippet ()
          (if (not (boundp 'yas-minor-mode))
              (progn
                (let* ((yas-dir "~/.dotfiles/emacs/emacs.d.symlink/snippets"))
                  (setq yas-snippet-dirs yas-dir)
                  (yas-global-mode 1)))))
      (add-to-hooks 'bindings/load-yasnippet '(prog-mode-hook
                                               org-mode-hook)))
    :config
    (progn
      (spacemacs|diminish yas-minor-mode " Ⓨ")
      (require 'helm-c-yasnippet)
      (evil-leader/set-key "is" 'helm-yas-complete)
      (setq helm-c-yas-space-match-any-greedy t))))

(defun bindings/init-projectile ()
  (use-package projectile))
