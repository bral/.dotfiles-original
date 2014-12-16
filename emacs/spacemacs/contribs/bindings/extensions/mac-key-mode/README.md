This package provides mac-key-mode, a minor mode that provides
mac-like key bindings and relevant elisp functions.

To use this package, add these lines to your .emacs file:

;;    (require 'redo+)
(require 'mac-key-mode)
(mac-key-mode 1)

Note that mac-key-mode requires redo+.el.
In order to set additional key bindings,
modify mac-key-mode-map in your .emacs file:

(require 'mac-key-mode)
(define-key mac-key-mode-map [(alt l)] 'goto-line)

When mac-key-mode is on, command key is recognized as 'alt' key,
but option (alt) key is also recognized as 'alt' key.
If you would like to use option (alt) key as meta key,
add the below line to your .emacs.el.

(add-hook 'mac-key-mode-hook
(lambda()
(interactive)
(if mac-key-mode
(setq mac-option-modifier 'meta)
(setq mac-option-modifier nil)
)))

Mac-key-mode takes advantage of additional functions, provided by
the mac-functions.patch &lt;http://homepage.mac.com/zenitani/comp-e.html&gt;.
(e.g. mac-spotlight-search, mac-spotlight-search etc.)

