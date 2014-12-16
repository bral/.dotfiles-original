(require-package 'evil)
(setq-default evil-want-C-u-scroll t)
(setq-default evil-shift-width 2)
(evil-mode 1)

(require-package 'evil-surround)
(global-surround-mode 1)

(require-package 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")

(require-package 'evil-numbers)

;; Colored modes
(lexical-let ((default-color (cons (face-background 'mode-line)
                                   (face-foreground 'mode-line))))
  (add-hook 'post-command-hook
            (lambda ()
              (let ((color (cond ((minibufferp) default-color)
                                 ((evil-insert-state-p) '("#5f8700" . "#ffffff"))
                                 ((evil-emacs-state-p)  '("#444488" . "#ffffff"))
                                 ((buffer-modified-p)   '("#0087ff" . "#ffffff"))
                                 (t default-color))))
                (set-face-background 'mode-line (car color))
                (set-face-foreground 'mode-line (cdr color))))))

;; Maybe exit
(evil-define-command maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p)))
         (insert "k")
    (let ((evt (read-event (format "Insert %c to exit insert state" ?j)
               nil 0.5)))
      (cond
       ((null evt) (message ""))
       ((and (integerp evt) (char-equal evt ?j))
    (delete-char -1)
    (set-buffer-modified-p modified)
    (push 'escape unread-command-events))
       (t (setq unread-command-events (append unread-command-events
                          (list evt))))))))

(define-key evil-emacs-state-map "k" #'maybe-exit)
(define-key evil-insert-state-map "k" #'maybe-exit)
(define-key evil-replace-state-map "k" #'maybe-exit)
(define-key evil-visual-state-map "K" #'maybe-exit)

;; Better line openings.
(defun open-line-below ()
  (interactive)
  (point-to-register 1)
  (end-of-line)
  (newline)
  (indent-for-tab-command)
  (beginning-of-line)
  (delete-trailing-whitespace)
  (jump-to-register 1))

(defun open-line-above ()
  (interactive)
  (point-to-register 1)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command)
  (beginning-of-line)
  (delete-trailing-whitespace)
  (jump-to-register 1))

(define-key evil-normal-state-map "[ " 'open-line-above)
(define-key evil-normal-state-map "] " 'open-line-below)

;; Scroll
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)

;; Numbers
(define-key evil-normal-state-map (kbd "C-H-a") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-H-x") 'evil-numbers/dec-at-pt)

;; Insert
(define-key evil-insert-state-map (kbd "C-h") 'left-char)
(define-key evil-insert-state-map (kbd "C-j") 'next-line)
(define-key evil-insert-state-map (kbd "C-k") 'previous-line)
(define-key evil-insert-state-map (kbd "C-l") 'right-char)

;; Move line or region
(define-key evil-normal-state-map (kbd "C-S-J") 'move-text-down)
(define-key evil-visual-state-map (kbd "C-S-J") 'move-text-down)

(define-key evil-visual-state-map (kbd "C-S-K") 'move-text-up)
(define-key evil-normal-state-map (kbd "C-S-K") 'move-text-up)

;; Comments
(define-key evil-normal-state-map (kbd "gc") 'comment-or-uncomment-region)

;; Window / Buffer
(define-key evil-normal-state-map "-" 'delete-other-windows)
(define-key evil-normal-state-map (kbd "C-w C-w") 'save-buffer-always)

;; Eval
(evil-leader/set-key "r" 'eval-region)
(evil-leader/set-key "b" 'eval-buffer)
(evil-leader/set-key "s" 'eval-last-sexp)
(evil-leader/set-key "S" 'eval-last-sexp)

;; Lambda
(define-key evil-insert-state-map (kbd "A-l") (λ (insert "\u03bb")))
(define-key evil-normal-state-map (kbd "A-l") (λ (insert "\u03bb")))

;; Jump from init-window-manager.el
(window-evil-bindings)

;; Version control
(evil-leader/set-key "g" 'magit-status)

(add-hook 'js2-mode-hook
  (lambda ()
    ;; Scan the file for nested code blocks
    (imenu-add-menubar-index)
    ;; Activate the folding mode
    (hs-minor-mode t)))

(define-key evil-normal-state-map (kbd "A-.") 'hs-show-block)
(define-key evil-normal-state-map (kbd "A->") 'hs-show-all)
(define-key evil-normal-state-map (kbd "A-,") 'hs-hide-block)
(define-key evil-normal-state-map (kbd "A-<") 'hs-hide-all)

(defun js2-mode-hide-all ()
  (interactive)
  (js2-mode-hide-functions)
  (js2-mode-hide-comments)
  (js2-mode-hide-element)
  )

(provide 'init-evil)
