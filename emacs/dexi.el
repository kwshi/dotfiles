(load-file "~/.emacs.d/straight/repos/straight.el/bootstrap.el")

(setq inhibit-splash-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq-default fill-column 70)
(global-display-line-numbers-mode)
(column-number-mode)

(setq-default c-basic-offset 2)
(setq-default sh-basic-offset 2)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

(setq auto-save-default nil)
(setq make-backup-files nil)
(setq create-lockfiles nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; set font
(set-frame-font "Roboto Mono-11" nil t)

;; gruvbox theme
(straight-use-package 'gruvbox-theme)
(load-theme 'gruvbox-dark-medium 'no-confirm)

;; lsp
(straight-use-package 'lsp-mode)

;; undo tree
(straight-use-package 'undo-tree)

;; latex
(straight-use-package 'auctex)
(add-hook
 'LaTeX-mode-hook
 (lambda ()
   (setcdr (assoc "align*" LaTeX-indent-environment-list) '())
   (setcdr (assoc "align" LaTeX-indent-environment-list) '())
   (setcdr (assoc "array" LaTeX-indent-environment-list) '())))

;; markdown
(straight-use-package 'markdown-mode+)
(straight-use-package 'markdown-mode)
;;(set-face-attribute
;; 'markdown-inline-code-face
;; nil
;; :family "Roboto Mono")

;; python
(straight-use-package 'jedi)
(straight-use-package 'blacken)
(straight-use-package 'python-docstring)
(add-hook 'python-mode-hook 'python-docstring-mode)
(add-hook 'python-mode-hook 'blacken-mode)

;; evil
(straight-use-package 'evil)
(evil-mode 1)

;; whitespace
(straight-use-package 'ws-butler)
(ws-butler-global-mode)

;; nix
(straight-use-package 'nix-mode)


;; elvish
(straight-use-package 'elvish-mode)

;; asciidoc
(straight-use-package 'asciidoc)
(straight-use-package 'adoc-mode)

;; textile
(straight-use-package 'textile-mode)

;; elm
(straight-use-package 'elm-mode)
(elm-format-on-save-mode)

;; ocaml
(straight-use-package 'tuareg)
(straight-use-package 'reason-mode)
(straight-use-package 'merlin)
(straight-use-package 'dune)
(straight-use-package 'ocp-indent)
(add-hook 'tuareg-mode-hook 'merlin-mode)
(add-hook 'reason-mode-hook 'merlin-mode)
(setq-default merlin-command "/run/current-system/sw/bin/ocamlmerlin")
(ocp-setup-indent)

;; rust
(straight-use-package 'rust-mode)
(setq-default rust-indent-offset 2)

;; openscad
;;(straight-use-package 'scad-mode)
;;(straight-use-package 'scad-preview)

;; yaml
(straight-use-package 'yaml-mode)

;; toml
(straight-use-package 'toml-mode)
(straight-use-package 'toml)

;; js
(setq-default js-indent-level 2)
(straight-use-package 'prettier-js)

;; factor
(straight-use-package 'fuel)


;; css
(setq-default css-indent-offset 2)

;;
(straight-use-package 'yasnippet)
(yas-global-mode)
(setq-default yas-triggers-in-field t)

;;
(straight-use-package 'kotlin-mode)
(setq-default kotlin-tab-width 2)

;;
(straight-use-package 'dockerfile-mode)
