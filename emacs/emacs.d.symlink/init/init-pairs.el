;; auto pair
(when (fboundp 'electric-pair-mode)
  (setq-default electric-pair-mode 1))

;; match parens
(show-paren-mode 1)

(provide 'init-pairs)
