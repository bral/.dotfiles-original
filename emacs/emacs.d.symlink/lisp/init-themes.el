(require-package 'color-theme)
(require-package 'color-theme-sanityinc-solarized)

(setq-default custom-enabled-themes '(sanityinc-solarized-dark))

(defun reapply-themes ()
  "Forcibly load the themes listed in `custom-enabled-themes'."
  (dolist (theme custom-enabled-themes)
    (unless (custom-theme-p theme)
      (load-theme theme)))
  (custom-set-variables `(custom-enabled-themes (quote ,custom-enabled-themes))))

(reapply-themes)

(provide 'init-themes)
