(setq evil-shift-width 2)

;; increase text globally instead of by-buffer
(defadvice text-scale-increase (around all-buffers (arg) activate)
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      ad-do-it)))

;; ignore useless files
(eval-after-load 'ido '(add-to-list 'ido-ignore-files "\\.DS_Store"))
(eval-after-load 'ido '(add-to-list 'ido-ignore-files "\\.tern-port"))
