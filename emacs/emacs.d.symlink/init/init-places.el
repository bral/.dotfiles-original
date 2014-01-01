(require-package 'saveplace)
(setq-default saveplace t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

(provide 'init-places)
