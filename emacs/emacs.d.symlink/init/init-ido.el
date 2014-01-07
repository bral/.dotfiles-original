(require-package 'ido)

(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point nil)
(setq ido-auto-merge-work-directories-length 0)
(setq ido-use-virtual-buffers t)

(when (eval-when-compile (>= emacs-major-version 24))
 (require-package 'ido-ubiquitous)
 (ido-ubiquitous-mode t))

;; Use smex to handle M-x
(require-package 'smex)
(global-set-key [remap execute-extended-command] 'smex)

(require-package 'idomenu)

(require-package 'ido-vertical-mode)
(ido-vertical-mode t)

;; Allow the same buffer to be open in different frames
(setq ido-default-buffer-method 'selected-window)

;; Ignore files
(add-to-list 'completion-ignored-extensions ".DS_Store")
(add-to-list 'completion-ignored-extensions ".ecl")

(provide 'init-ido)
