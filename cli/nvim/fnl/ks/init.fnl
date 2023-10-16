(local lazy (require :lazy))

(local {: spec} (require :ks.lib.lazy))

(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

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
(vim.api.nvim_create_autocmd [:BufEnter]
                             {:callback #(set vim.o.formatoptions :qjmMl)})

;; TODO belongs with a plugin?
(vim.keymap.set :n :<leader>e vim.diagnostic.open_float)

(vim.filetype.add {:extension {:mdx :markdown :hy :hy}})

(lazy.setup [(require :ks.spec.gruvbox)
             (spec :rktjmp/hotpot.nvim)
             (require :ks.spec.colorizer)
             (require :ks.spec.treesitter)
             (spec :nvim-lua/lsp-status.nvim)
             (require :ks.spec.lspconfig)
             (require :ks.spec.telescope)
             (require :ks.spec.cmp)
             (spec :bakpakin/fennel.vim)
             (require :ks.spec.vimtex)
             (spec :JuliaEditorSupport/julia-vim
                   {:config #(set vim.g.latex_to_unicode_tab false)})
             (require :ks.spec.luasnip)
             (spec :psliwka/vim-smoothie
                   {:config #(do
                               (set vim.g.smoothie_speed_linear_factor 30)
                               (set vim.g.smoothie_speed_exponentiation_factor
                                    0.75))})
             (spec :folke/trouble.nvim
                   {:config #(let [trouble (require :trouble)]
                               (trouble.setup {}))})
             (spec :nvim-lua/plenary.nvim)
             (require :ks.spec.null-ls)] {:performance {}})
