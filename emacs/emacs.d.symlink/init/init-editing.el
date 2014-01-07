;; Copy an inactive line
(require-package 'whole-line-or-region)

;; Auto-revert any open files/buffers
(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t
  auto-revert-verbose nil)

;; Highlight symbols
(require-package 'highlight-symbol)
(dolist (hook '(prog-mode-hook html-mode-hook))
  (add-hook hook 'highlight-symbol-mode)
  (add-hook hook 'highlight-symbol-nav-mode))
(eval-after-load 'highlight-symbol
  '(diminish 'highlight-symbol-mode))

;; Expand regions
(require-package 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; Sublime Textish
;; -- comment
(global-set-key (kbd "A-/") 'comment-or-uncomment-region)
;; -- indent

;; (defun indent-line-once ()
;;   (interactive)
;;   (point-to-register 1)
;;   (beginning-of-line)
;;     (indent-line-to 2)
;;   (jump-to-register 1))

;; (defun my-indent-region (N)
;;   (interactive "p")
;;   (if (use-region-p)
;;       (progn (indent-rigidly (region-beginning) (region-end) (* N 2))
;;              (setq deactivate-mark nil))
;;     (λ
;;       (interactive)
;;       (point-to-register 1)
;;       (beginning-of-line)
;;       (set-mark-command)
;;       (end-of-line)
;;       (indent-rigidly)
;;       (jump-to-register 1))))

;;     ;; (self-insert-command N)))

;; (define-key mac-key-mode-map [(alt \])] 'indent-line-once)

   (global-set-key (kbd "A-[") 'indent-line-once)
   (global-set-key (kbd "A-[") 'indent-line-once)
   (global-set-key (kbd "A-[") 'indent-line-once)
   (global-set-key (kbd "A-[") 'indent-line-once)



(provide 'init-editing)
