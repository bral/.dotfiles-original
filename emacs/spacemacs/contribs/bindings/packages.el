(defvar bindings-packages
  '(
    projectile
    windmove
    yasnippet
    zoom-frm
    ))

(defun bindings/init-yasnippet ()
  (use-package yasnippet
    :config
    (progn
      (spacemacs|diminish yas-minor-mode " Ⓨ")
      (require 'helm-c-yasnippet)
      (evil-leader/set-key "is" 'helm-yas-complete)
      (setq helm-c-yas-space-match-any-greedy t))
      (setq yas-snippet-dirs (expand-file-name "~/.dotfiles/emacs/emacs.d.symlink/snippets"))
      (yas-global-mode 1)
      ))

(defun bindings/init-projectile ()
  (use-package projectile))
