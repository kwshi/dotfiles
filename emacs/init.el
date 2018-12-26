(let ((bootstrap-file (concat user-emacs-directory "straight/bootstrap.el"))
      (bootstrap-version 2))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq inhibit-splash-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)


(straight-use-package 'gruvbox-theme)
(load-theme 'gruvbox-dark-soft 'no-confirm)
;; (load-theme 'gruvbox-light-soft)

(straight-use-package 'yasnippet)
(yas-global-mode 1)

(straight-use-package 'yaml-mode)

(straight-use-package 'use-package)

(straight-use-package 'racket-mode)
(straight-use-package 'go-mode)

(straight-use-package 'python-mode)

(straight-use-package 'json-mode)

(straight-use-package 'xml+)

(straight-use-package 'py-autopep8)
(straight-use-package 'python-docstring)

(straight-use-package 'undo-tree)
(global-undo-tree-mode)

;;(straight-use-package 'anaconda-mode)
;;(py-autopep8-enable-on-save)
;;(python-docstring-mode)

(straight-use-package 'elpy)
(elpy-enable)

(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(add-hook 'elpy-mode-hook 'python-docstring-mode)

(straight-use-package 'haskell-mode)
(straight-use-package 'rust-mode)

(straight-use-package 'scad-mode)

(straight-use-package 'rjsx-mode)
(setq js-indent-level 2)
;;(straight-use-package 'jsx-mode)
(straight-use-package 'prettier-js)
(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)

(straight-use-package 'rustfmt)
(add-hook 'rust-mode-hook 'rustfmt-enable-on-save)

(straight-use-package 'markdown-mode+)
(straight-use-package 'markdown-toc)

(straight-use-package 'ws-butler)
(ws-butler-global-mode)

(straight-use-package 'ess)

(straight-use-package 'elvish-mode)

(straight-use-package 'aggressive-indent)
(aggressive-indent-global-mode)

(straight-use-package 'aggressive-fill-paragraph)
(aggressive-fill-paragraph-mode)

(straight-use-package 'auctex)
(setq font-latex-fontify-script nil)


(setq-default fill-column 70)
(global-display-line-numbers-mode)

(setq-default c-basic-offset 2)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)



(setq auto-save-default nil)
(setq make-backup-files nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
