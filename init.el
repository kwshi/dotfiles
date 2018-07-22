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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "95b0bc7b8687101335ebbf770828b641f2befdcf6d3c192243a251ce72ab1692" "82fce2cada016f736dbcef237780516063a17c2436d1ee7f42e395e38a15793b" "feae5c57b2ac064256066fd6cb28df8701563399006ccf6bd84295f1ad4efdb1" "5a970147df34752ed45bfdf0729233abfc085d9673ae7e40210c5e2d8f624b08" "125fd2180e880802ae98b85f282b17f0aa8fa6cb9fc4f33d7fb19a38c40acef0" "2b6bd2ebad907ee42b3ffefa4831f348e3652ea8245570cdda67f0034f07db93" "65d9573b64ec94844f95e6055fe7a82451215f551c45275ca5b78653d505bc42" "dc9a8d70c4f94a28aafc7833f8d05667601968e6c9bf998791c39fcb3e4679c9" "f6a935e77513ba40014aa8467c35961fdb1fc936fa48407ed437083a7ad932de" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq inhibit-splash-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(straight-use-package 'gruvbox-theme)
(load-theme 'gruvbox-dark-soft)
;; (load-theme 'gruvbox-light-soft)

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
;;

(straight-use-package 'elpy)
(elpy-enable)

(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(add-hook 'elpy-mode-hook 'python-docstring-mode)

(straight-use-package 'haskell-mode)
(straight-use-package 'rust-mode)

(straight-use-package 'scad-mode)

(straight-use-package 'rjsx-mode)
;;(straight-use-package 'jsx-mode)

(straight-use-package 'rustfmt)
(add-hook 'rust-mode-hook 'rustfmt-enable-on-save)

(straight-use-package 'markdown-mode+)
(straight-use-package 'markdown-toc)

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
