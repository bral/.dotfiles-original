(define-prefix-command (key-binding "\C-q"))

(global-set-key (kbd "C-q %") 'split-window-vertically)
(global-set-key (kbd "C-q \"") 'split-window-horizontally)

(global-set-key (kbd "C-q h") 'evil-window-left)
(global-set-key (kbd "C-q l") 'evil-window-right)
(global-set-key (kbd "C-q j") 'evil-window-down)
(global-set-key (kbd "C-q k") 'evil-window-up)

(global-set-key (kbd "C-q x") 'delete-window)

(provide 'init-tmux)
