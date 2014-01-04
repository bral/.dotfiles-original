(require-package 'color-theme)
(require-package 'color-theme-solarized)

(set-face-attribute 'default nil
  :family "Menlo" :height 180 :weight 'normal)

(setq-default custom-enabled-themes '(solarized-dark))

(defun reapply-themes ()
  "Forcibly load the themes listed in `custom-enabled-themes'."
  (dolist (theme custom-enabled-themes)
    (unless (custom-theme-p theme)
      (load-theme theme t)))
  (custom-set-variables `(custom-enabled-themes (quote ,custom-enabled-themes))))

(reapply-themes)

(provide 'init-themes)
