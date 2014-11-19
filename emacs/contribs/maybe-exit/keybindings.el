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
