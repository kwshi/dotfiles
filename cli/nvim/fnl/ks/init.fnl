(set vim.o.number true)
(set vim.o.termguicolors true)
(set vim.o.expandtab true)
(set vim.o.autochdir true)


(set vim.o.shiftwidth 2)
(set vim.o.tabstop 2)
(set vim.o.signcolumn :number)
(set vim.o.wildmode "list:longest")
(set vim.o.backupcopy :yes)
(set vim.o.inccommand :nosplit)
(set vim.o.mouse :a)

(set vim.o.textwidth 80)
;(set vim.o.formatoptions :qjmMl)
(vim.api.nvim_create_autocmd
  [:BufEnter]
  {:callback #(set vim.o.formatoptions :qjmMl)})

(vim.api.nvim_command "colorscheme gruvbox")

(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

(vim.keymap.set :n :<space> :<nop>)
(vim.keymap.set :n :<leader>F :<cmd>GFiles<cr>)
(vim.keymap.set :n :<leader>f :<cmd>Files<cr>)
(vim.keymap.set :n :<leader>b :<cmd>Buffers<cr>)

(vim.keymap.set :n :<leader>e vim.diagnostic.open_float)

(require :ks.misc.fcitx)
(require :ks.misc.hexokinase)
(require :ks.misc.latex-to-unicode)
(require :ks.misc.prettier)
(require :ks.misc.smoothie)
;;(require :ks.misc.ultisnips)
(require :ks.misc.lsp-status)
(require :ks.misc.web-devicons)
(require :ks.misc.firenvim)
(require :ks.misc.luasnip)
(require :ks.misc.conjure)
(require :ks.misc.hp)
(require :ks.misc.treesitter)

(require :ks.lang.python)
(require :ks.lang.c)
(require :ks.lang.tex)
(require :ks.lang.typescript)
(require :ks.lang.elm)
(require :ks.lang.svelte)
(require :ks.lang.ocaml)
(require :ks.lang.haskell)
(require :ks.lang.vue)
(require :ks.lang.julia)
(require :ks.lang.rust)
(require :ks.lang.go)
(require :ks.lang.astro)
