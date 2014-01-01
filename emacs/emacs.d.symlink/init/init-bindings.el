;; I don't need to kill emacs that easily
;; the mnemonic is C-x REALLY QUIT
(global-set-key (kbd "C-x r q") 'save-buffers-kill-terminal)
(global-set-key (kbd "C-x C-c") 'delete-frame)

;; Map 'RET' to newline + indent
(global-set-key (kbd "RET") 'newline-and-indent)

(provide 'init-bindings)
