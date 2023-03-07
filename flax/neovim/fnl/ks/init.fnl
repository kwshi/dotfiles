;; lazy.nvim bootstrap
(let [lazypath (.. (vim.fn.stdpath :data) "/lazy/lazy.nvim")]
  (if (not (vim.loop.fs_stat lazypath))
    (vim.fn.system
      [:git :clone
       "--filter=blob:none"
       "--branch=v9.5.0"
       "https://github.com/folke/lazy.nvim.git"
       lazypath]))
  (vim.opt.rtp:prepend lazypath))

(local lazy (require :lazy))

(fn spec [plugin args]
  (let [tbl [plugin] args (or args {})]
    (each [k v (pairs args)] (tset tbl k v))
    tbl))

(lazy.setup
  [(spec :gruvbox-community/gruvbox
         {:lazy false
         :config #(vim.cmd "colorscheme gruvbox")})
   (spec :nvim-treesitter/nvim-treesitter
         {:config #(let [ts (require :nvim-treesitter.configs)]
                     (ts.setup {:auto_install true
                     :highlight {:enable true}}))})
   (spec :bakpakin/fennel.vim)
   (spec :psliwka/vim-smoothie
         {:config
          #(do
             (set vim.g.smoothie_speed_linear_factor 30)
             (set vim.g.smoothie_speed_exponentiation_factor .75))})
   (spec :jose-elias-alvarez/null-ls.nvim
         {:config #(do)})
   (spec :folke/trouble.nvim)
   (spec :neovim/nvim-lspconfig
         {:config 
          (fn [] (let [lsp (require :lspconfig)
                 format (fn [async] (vim.lsp.buf.format {: async :filter #(~= $ :tsserver)}))
                 on-attach
                 (fn [client buffer]
                   (let [bufopts {:noremap true :silent true : buffer}]
                     (vim.keymap.set :n :<leader><leader> vim.lsp.buf.hover bufopts)
                     (vim.keymap.set :n :<leader>f #(format true) bufopts)
                     (vim.api.nvim_create_autocmd [:BufWritePre]
                                                  {: buffer :callback #(format false)})))]
             (lsp.rnix.setup {:on_attach on-attach})
             (lsp.ccls.setup {:on_attach on-attach})
             ))})
   ]
  {:install {:colorscheme [:gruvbox]}
   :performance {:reset_packpath false}})

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


(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

(vim.keymap.set :n :<space> :<nop>)
(vim.keymap.set :n :<leader>e vim.diagnostic.open_float)

;(require :ks.misc.fcitx)
;(require :ks.misc.hexokinase)
;(require :ks.misc.latex-to-unicode)
;(require :ks.misc.prettier)
;(require :ks.misc.smoothie)
;;;(require :ks.misc.ultisnips)
;(require :ks.misc.lsp-status)
;(require :ks.misc.web-devicons)
;(require :ks.misc.firenvim)
;(require :ks.misc.luasnip)
;(require :ks.misc.conjure)
;(require :ks.misc.hp)
;(require :ks.misc.treesitter)
;
;(require :ks.lang.python)
;(require :ks.lang.c)
;(require :ks.lang.tex)
;(require :ks.lang.typescript)
;(require :ks.lang.elm)
;(require :ks.lang.svelte)
;(require :ks.lang.ocaml)
;(require :ks.lang.haskell)
;(require :ks.lang.vue)
;(require :ks.lang.julia)
;(require :ks.lang.rust)
;(require :ks.lang.go)
;(require :ks.lang.astro)
