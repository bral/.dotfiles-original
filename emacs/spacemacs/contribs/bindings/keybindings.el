;; vim/evil

(setq-default evil-escape-key-sequence (kbd "kj"))

(define-key evil-normal-state-map "[ " 'bindings/open-line-above)
(define-key evil-normal-state-map "] " 'bindings/open-line-below)

(define-key evil-insert-state-map (kbd "C-h") 'left-char)
(define-key evil-insert-state-map (kbd "C-j") 'next-line)
(define-key evil-insert-state-map (kbd "C-k") 'previous-line)
(define-key evil-insert-state-map (kbd "C-l") 'right-char)

;; scale

(global-set-key (caps-lock-bind "-") 'text-scale-decrease)
(global-set-key (caps-lock-bind "=") 'text-scale-increase)

(define-key mac-key-mode-map [(alt -)] 'zoom-frm-out)
(define-key mac-key-mode-map [(alt =)] 'zoom-frm-in)

;; frames & screens

(define-key mac-key-mode-map [(alt f)] 'toggle-frame-fullscreen)
(define-key mac-key-mode-map [(alt n)] 'new-frame)
(define-key mac-key-mode-map [(alt t)] 'elscreen-create-last-buffer)
(define-key mac-key-mode-map [(alt })] 'elscreen-next)
(define-key mac-key-mode-map [(alt {)] 'elscreen-previous)
(define-key mac-key-mode-map [(alt w)] 'elscreen-kill-maybe)

;; panes & windows

(global-set-key (caps-lock-bind "h") 'windmove-left)
(global-set-key (caps-lock-bind "j") 'windmove-down)
(global-set-key (caps-lock-bind "k") 'windmove-up)
(global-set-key (caps-lock-bind "l") 'windmove-right)

(global-set-key (caps-lock-bind "s") 'split-window-horizontally-and-switch)
(global-set-key (caps-lock-bind "v") 'split-window-vertically-and-switch)
(global-set-key (caps-lock-bind "w") 'delete-window)

;; projectile

(define-prefix-command (key-binding (kbd "A-p")))

(global-set-key (kbd "A-p P") 'projectile-mode)

(define-key projectile-mode-map (kbd "A-p d") 'projectile-find-dir)
(define-key projectile-mode-map (kbd "A-p p") 'projectile-switch-project)
(define-key projectile-mode-map (kbd "A-p f") 'projectile-find-file)
(define-key projectile-mode-map (kbd "A-p e") 'projectile-recentf)
(define-key projectile-mode-map (kbd "A-p r") 'projectile-replace)
(define-key projectile-mode-map (kbd "A-p R") 'projectile-regenerate-tags)
(define-key projectile-mode-map (kbd "A-p g") 'projectile-grep)

;; eshell

(global-set-key (kbd "A-M-:") 'eshell)

;; misc

(global-set-key (kbd "A-,") 'customize)
