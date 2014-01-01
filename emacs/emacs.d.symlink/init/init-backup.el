;;; Don't clutter the directories

;; Write backup files to own directory
(defconst temporary-file-dir
  (expand-file-name (concat user-emacs-directory "backup")))

(setq backup-directory-alist
  `((".*" . ,temporary-file-dir)))

(setq auto-save-file-name-transforms
  `((".*" ,temporary-file-dir t)))

(setq auto-save-list-file-prefix
  temporary-file-dir)

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Don't make lock files
(setq create-lockfiles nil)

(provide 'init-backup)
