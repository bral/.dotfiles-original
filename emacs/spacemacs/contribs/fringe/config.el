;; linum-mode

(setq linum-format " %4d ")

(setq global-linum-mode t)

;; Thanks @Starkey
;; http://stackoverflow.com/questions/3875213/turning-on-linum-mode-when-in-python-c-mode
(setq linum-mode-inhibit-modes-list
  '(
    spacemacs
    spacemacs-mode
    eww-mode
    eshell-mode
    shell-mode
    erc-mode
    jabber-roster-mode
    jabber-chat-mode
    gnus-group-mode
    gnus-summary-mode
    gnus-article-mode
    ))

(defadvice linum-on (around linum-on-inhibit-for-modes)
  "Stop the load of linum-mode for some major modes."
    (unless (member major-mode linum-mode-inhibit-modes-list)
      ad-do-it))

(ad-activate 'linum-on)

(custom-set-faces
 '(linum ((t (:background "#073642" :foreground "#586e75")))))

(custom-set-variables
 '(fringe-mode 0 nil (fringe))
 '(global-vi-tilde-fringe-mode nil)
 )
