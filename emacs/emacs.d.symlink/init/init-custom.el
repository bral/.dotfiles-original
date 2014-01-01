;; Keep emacs Custom-settings in separate file
(expand-file-name ".custom.el" user-emacs-directory)
(setq custom-file (expand-file-name ".custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(provide 'init-custom)