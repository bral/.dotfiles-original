;;; sjs-mode.el --- Minor mode to edit Sweet.js files in Emacs -*- lexical-binding: t; -*-

;; Copyright (C) 2014 Tim Disney

;; Version: 0.1.0
;; Keywords: Javascript minor mode
;; Author: Tim Disney <tim@disnet.me>
;; URL: http://github.com/disnet/sjs-mode
;; Package-Requires: ((emacs "24.1") (cl-lib "0.5"))

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;; Minor mode for sjs files. Adds some syntax highlighting and
;; commands for compiling sweet.js files.
;;
;; Keybindings:
;;
;;    C-c s r  compile region
;;    C-c s c  compile buffer
;;

;;; Installation:

;; In your emacs config:

;;      (add-to-list 'load-path "/path/to/sjs-mode")
;;      (require 'sjs-mode)

;; If you want to turn in on for all JavaScript files:

;;      (add-hook 'js-mode 'sjs-mode)

;;; Code:

(defgroup sjs nil
  "A minor mode for sweet.js"
  :group 'languages)

(defcustom sjs-command "sjs"
  "The sweet.js binary used for compiling code. Must be in the path."
  :type 'string
  :group 'sjs)

(defcustom sjs-compile-buffer "*sjs-compile*"
  "The name of the scratch buffer."
  :type 'string
  :group 'sjs)

(defvar sjs-keywords-regexp (regexp-opt
                                 '("macro" "rule" "operator")
                                 'words))

(defvar sjs-font-lock-keywords
  `((,sjs-keywords-regexp . font-lock-keyword-face)))

(defun sjs-turn-on ()
  "Turn on sjs mode."
  (font-lock-add-keywords nil sjs-font-lock-keywords))

(defun sjs-turn-off ()
  "Turn off sjs mode."
  (font-lock-remove-keywords nil sjs-font-lock-keywords))

(defun sjs-compile-region (start end)
  "Compile the region."
  (interactive "r")
  (message "compiling")

  (let ((buffer (get-buffer sjs-compile-buffer)))
    (when buffer
      (kill-buffer buffer)))

  (apply (apply-partially 'call-process-region start end sjs-command nil
                          (get-buffer-create sjs-compile-buffer)
                          nil)
         (list "-s"))

  (with-current-buffer sjs-compile-buffer
    (js2-mode))

  (display-buffer-other-frame sjs-compile-buffer))


(defvar sjs-mode-keymap (make-sparse-keymap))
(define-key sjs-mode-keymap (kbd "C-c s c") 'sjs-compile-buffer)
(define-key sjs-mode-keymap (kbd "C-c s r") 'sjs-compile-region)

(defun sjs-compile-buffer ()
  (interactive)
  (sjs-compile-region (point-min) (point-max)))

(define-minor-mode sjs-mode
  "Adds some sjs convenience functions to emacs"
  nil
  " Sjs"
  sjs-mode-keymap
  (if sjs-mode (sjs-turn-on) (sjs-turn-off)))


(provide 'sjs-mode)

;;; sjs-mode ends here
