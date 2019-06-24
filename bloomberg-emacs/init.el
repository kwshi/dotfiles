(add-to-list 'load-path "~/.emacs.d/packages/dash.el")
(add-to-list 'load-path "~/.emacs.d/packages/autothemer")
(add-to-list 'load-path "~/.emacs.d/packages/emacs-theme-gruvbox")
(add-to-list 'load-path "~/.emacs.d/packages/undo-tree")

(add-to-list 'custom-theme-load-path "~/.emacs.d/packages/emacs-theme-gruvbox")
(load-theme 'gruvbox-dark-soft t)

(require 'undo-tree)
(global-undo-tree-mode)

(add-to-list 'default-frame-alist '(font . "Roboto Mono-11"))
(set-face-attribute 'default nil :font "Roboto Mono-11")

(setq inhibit-splash-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)


(setq-default fill-column 70)
(global-display-line-numbers-mode)

(setq-default c-basic-offset 2)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)



(setq auto-save-default nil)
(setq make-backup-files nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


