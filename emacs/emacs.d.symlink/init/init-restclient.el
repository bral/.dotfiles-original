(require-package 'restclient)

(defun open-http-buffer()
  "Opens an http buffer"
  (interactive)
  (let ((buf "*Rest Client*"))
    (if (eq nil (get-buffer buf))
      (with-current-buffer (get-buffer-create buf)
	(restclient-mode)
	(insert
	  (concat
	    "#\n# Variables\n#\n\n"
	    ":auth-token = token123\n\n"
	    "#\n# Simple GET\n#\n"
	    "GET http://127.0.0.1:5000\n\n"
	    "authorization: Bearer :auth-token\n\n"
	    "#\n# POST with json\n#\n"
	    "POST http://127.0.0.1:5000\n\n"
	    "authorization: Bearer :auth-token\n"
	    "content-type: application/json\n\n"
	    "{}\n"))))
  (with-current-buffer (get-buffer buf)
    (pop-to-buffer (current-buffer)))))

(global-set-key (kbd "A-r") 'open-http-buffer)
(global-set-key (kbd "A-R") 'open-http-buffer)

(defun open-link-in-rest-client(&optional event)
  "Opens a link in the rest client"
  (interactive (list last-input-event))
  (save-excursion
    (if event (posn-set-point (event-end event)))
    (let ((address (save-excursion (goto-address-find-address-at-point))))
	(let ((url (browse-url-url-at-point)))
	  (if url
	      (with-current-buffer (get-buffer-create "*Rest Client*")
		(goto-char (point-max))
		(insert (concat "\n#\nGET " url "\n\n"))
		(pop-to-buffer (current-buffer)))
	    (error "No e-mail address or URL found"))))))

(global-set-key [A-S-mouse-1] 'open-link-in-rest-client)

(add-to-list 'auto-mode-alist '("\\.http\\'" . restclient-mode))

(provide 'init-restclient)
