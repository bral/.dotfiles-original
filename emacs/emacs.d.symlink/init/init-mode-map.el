;; YAML
(autoload 'yaml-mode "yaml-mode")
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; CSS
(autoload 'turn-on-css-eldoc "css-eldoc")

;; Jade and Stylus (sws = significant whitespace)
(autoload 'sws-mode "sws-mode")
(autoload 'jade-mode "jade-mode")
(autoload 'styl-mode "styl-mode")

(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
(add-to-list 'auto-mode-alist '("\\.styl$" . styl-mode))
;; (add-to-list 'auto-mode-alist '("\\.css$" . rework-mode))

;; HTML
(add-to-list 'auto-mode-alist '("\\.html\\'" . html-mode))

;; Clojure
(autoload 'clojure-mode "clojure-mode")
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

;; SVG
(add-to-list 'auto-mode-alist '("\\.svg$" . image-mode))

;; JavaScript
(autoload 'js2-mode "js2-mode" nil t)
(require-package 'js2-mode)
(require-package 'json-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))
(add-to-list 'magic-mode-alist '("#!/usr/bin/env node" . js2-mode))

;; Markdown
(autoload 'markdown-mode "markdown-mode")
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))

;; Snippets
(autoload 'snippet-mode "snippet-mode")
(add-to-list 'auto-mode-alist '("yasnippet/snippets" . snippet-mode))
(add-to-list 'auto-mode-alist '("\\.yasnippet$" . snippet-mode))

;; Shell
(add-to-list 'auto-mode-alist '("\\.sh$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.zsh$" . shell-script-mode))

(provide 'init-mode-map)
