(require-package 'dash)
(require-package 's)

(defvar proto-project-prototypes nil
  "A list of projects")

(defvar proto-folder (expand-file-name "project-prototypes" user-emacs-directory)
  "Prototype projects directory")

(defvar proto-project-folder (expand-file-name "projects" "~")
  "Directory for new projects")

(defvar proto-out "*project-prototypes-output*"
  "Name of the buffer where output from the running process is displayed.")

(defun proto-declare-project-prototype (name fn)
  "Add project prototype to the list of available ones."
  (add-to-list 'proto-project-prototypes (cons name fn)))

(defun proto-create-project ()
  (interactive)
  (let ((name (completing-read "Prototype: " (-map 'car proto-project-prototypes) nil t)))
    (call-interactively (cdr (assoc name proto-project-prototypes)))))

(defun proto--join-patterns (patterns)
  "Turn `patterns' into a string that `find' can use."
  (mapconcat (lambda (pat) (format "-name \"%s\"" pat))
             patterns " -or "))

(defun proto--files-matching (patterns folder &optional type)
  (split-string (shell-command-to-string
                 (format "find %s %s \\( %s \\) | head -n %s"
                         folder
                         (or type "")
                         (proto--join-patterns patterns)
                         1000))))

(defun proto--instantiate-template-file (file replacements)
  (with-temp-file file
    (insert-file-contents-literally file)
    (--each replacements
      (goto-char 0)
      (while (search-forward (car it) nil t)
        (replace-match (cdr it))))))

(defun proto-sh (cmd)
  (shell-command cmd proto-out))

(defun proto-instantiate-template-directory (template folder &rest replacements)
  (let ((tmp-folder (expand-file-name (concat "__proto_tmp_" template) proto-project-folder)))
    (copy-directory (expand-file-name template proto-folder) tmp-folder nil nil t)
    (--each (proto--files-matching (--map (s-concat "*" (car it) "*") replacements) tmp-folder)
      (rename-file it (s-replace-all replacements it)))
    (--each (proto--files-matching ["*"] tmp-folder "-type f")
      (proto--instantiate-template-file it replacements))
    (copy-directory tmp-folder folder)
    (delete-directory tmp-folder t)))

(put 'proto-instantiate-template-directory 'lisp-indent-function 2)

(defmacro proto-with-new-project (project-name prototype replacements &rest body)
  `(let ((folder (expand-file-name ,project-name proto-project-folder)))
     (proto-instantiate-template-directory ,prototype folder ,@replacements)
     (view-buffer-other-window proto-out)
     (let ((default-directory (concat folder "/")))
       (proto-sh "git init")
       ,@body
       (proto-sh "git add -A")
       (proto-sh "git ci -m \"Initial commit\""))))

(put 'proto-with-new-project 'lisp-indent-function 2)

(when (file-exists-p proto-folder)
  (--each (directory-files proto-folder nil "^[^#].*el$")
    (load (expand-file-name it proto-folder))))

(provide 'init-project-prototypes)
