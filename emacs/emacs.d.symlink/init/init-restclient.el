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

(global-set-key (kbd "H-r") 'open-http-buffer)
(global-set-key (kbd "s-r") 'open-http-buffer)

(add-to-list 'auto-mode-alist '("\\.http\\'" . restclient-mode))

(provide 'init-restclient)
