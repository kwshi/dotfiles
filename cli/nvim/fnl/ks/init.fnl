(local lazy (require :lazy))

(fn spec [plugin opts]
  (let [tbl [plugin]]
    (each [k v (pairs (or opts {}))]
      (tset tbl k v))
    tbl))

(local on_attach
       (fn [client buffer]
         (let [opts {:noremap true :silent true : buffer}
               format (fn [async]
                        (vim.lsp.buf.format {: async
                                             :bufnr buffer
                                             :filter #(not= $.name :tsserver)}))]
           (vim.keymap.set :n :<leader><leader> vim.lsp.buf.hover opts)
           (vim.keymap.set :n :<leader>f #(format true) opts)
           (vim.keymap.set :n :<leader>d vim.lsp.buf.definition opts)
           (vim.keymap.set :n :<leader>t vim.lsp.buf.type_definition opts)
           (vim.keymap.set :n :<leader>r vim.lsp.buf.references opts)
           (vim.keymap.set :n :<leader>n vim.lsp.buf.rename opts)
           (vim.api.nvim_create_autocmd [:BufWritePre]
                                        {:callback #(format false) : buffer}))))

(lazy.setup [(spec :ellisonleao/gruvbox.nvim
                   {:config #(vim.cmd "colorscheme gruvbox")})
             (spec :rktjmp/hotpot.nvim)
             (spec :nvim-treesitter/nvim-treesitter
                   {:config #(let [ts (require :nvim-treesitter.configs)]
                               (ts.setup {:highlight {:enable true}
                                          :auto_install true}))})
             (spec :neovim/nvim-lspconfig
                   {:config (fn []
                              (let [lsp (require :lspconfig)]
                                (lsp.pyright.setup {: on_attach})
                                (lsp.tsserver.setup {: on_attach})
                                (lsp.gopls.setup {: on_attach})
                                (lsp.rust_analyzer.setup {: on_attach})
                                (lsp.rnix.setup {: on_attach})
                                ;(lsp.fennel-ls.setup {: on_attach})
                                (lsp.hls.setup {: on_attach})))})
             (spec :nvim-lua/lsp-status.nvim)
             (spec :nvim-telescope/telescope.nvim)
             (spec :bakpakin/fennel.vim)
             ;(spec :prettier/vim-prettier)
             (spec :lervag/vimtex
                   {:config #(let [tectonic-opts [:--keep-logs
                                                  :--synctex
                                                  :-Zshell-escape]
                                   latexmk-opts [:-shell-escape
                                                 :-verbose
                                                 :-file-line-error
                                                 :-synctex=1
                                                 :-interaction=nonstopmode
                                                 :-halt-on-error]
                                   list-envs [:example
                                              :subproblems
                                              :itemize
                                              :enumerate
                                              :spotlight]]
                               (set vim.g.vimtex_compiler_method :latexmk)
                               (set vim.g.vimtex_compiler_tectonic
                                    {:options tectonic-opts})
                               (set vim.g.vimtex_compiler_latexmk_engines
                                    {:_ :-lualatex
                                     :pdflatex :-pdflatex
                                     :lualatex :-lualatex})
                               (set vim.g.vimtex_compiler_latexmk
                                    {:build_dir :_build :options latexmk-opts})
                               (set vim.g.vimtex_view_method :zathura)
                               (set vim.g.vimtex_quickfix_open_on_warning false)
                               (set vim.g.vimtex_format_enabled true)
                               (set vim.g.vimtex_mappings_disable {:i ["]]"]})
                               (set vim.g.vimtex_imaps_enabled false)
                               (set vim.g.vimtex_indent_on_ampersands false)
                               (set vim.g.vimtex_indent_lists list-envs)
                               (set vim.g.vimtex_indent_tikz_commands false))})
             (spec :JuliaEditorSupport/julia-vim
                   {:config #(set vim.g.latex_to_unicode_tab false)})
             (spec :L3MON4D3/LuaSnip
                   {:dependencies [:julia-vim]
                    :config #(let [ls (require :luasnip)
                                   map-si (fn [key f]
                                            (vim.keymap.set :s key f)
                                            (vim.keymap.set :i key f))]
                               (ls.config.set_config {:update_events "TextChanged,TextChangedI"
                                                      :store_selection_keys :<tab>})
                               (vim.keymap.set :i :<tab>
                                               #(if (ls.expand_or_locally_jumpable)
                                                    (ls.expand_or_jump)
                                                    (vim.api.nvim_feedkeys "\t"
                                                                           :nt
                                                                           true)))
                               (vim.keymap.set :s :<tab> #(ls.jump 1))
                               (vim.keymap.set :s :<c-tab> #(ls.jump -1))
                               (map-si :<c-n> #(ls.change_choice 1))
                               (map-si :<c-p> #(ls.change_choice -1))
                               (require :ks.snippet.tex)
                               (ls.add_snippets :all
                                                (icollect [k v (pairs (vim.fn.julia_latex_symbols#get_dict))]
                                                  (ls.snippet {:trig k
                                                               :wordTrig false}
                                                              (ls.text_node v)))))})
             (spec :psliwka/vim-smoothie
                   {:config #(do
                               (set vim.g.smoothie_speed_linear_factor 30)
                               (set vim.g.smoothie_speed_exponentiation_factor
                                    0.75))})
             (spec :folke/trouble.nvim
                   {:config #(let [trouble (require :trouble)]
                               (trouble.setup {}))})
             (spec :nvim-lua/plenary.nvim)
             (spec :jose-elias-alvarez/null-ls.nvim
                   {:dependencies [:plenary.nvim]
                    :config #(let [nl (require :null-ls)]
                               (nl.setup {:sources [nl.builtins.diagnostics.alex
                                                    ;nl.builtins.formatting.alejandra
                                                    nl.builtins.formatting.black
                                                    nl.builtins.formatting.fnlfmt
                                                    nl.builtins.formatting.just
                                                    nl.builtins.formatting.prettierd
                                                    (nl.builtins.formatting.latexindent.with {:args [:-m
                                                                                                     :-l]})]
                                          : on_attach}))})]
            {:performance {}})

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
(vim.api.nvim_create_autocmd [:BufEnter]
                             {:callback #(set vim.o.formatoptions :qjmMl)})

(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

;; TODO belongs with a plugin?
(vim.keymap.set :n :<leader>e vim.diagnostic.open_float)

;
;(vim.keymap.set :n :<space> :<nop>)
;(vim.keymap.set :n :<leader>F :<cmd>GFiles<cr>)
;(vim.keymap.set :n :<leader>f :<cmd>Files<cr>)
;(vim.keymap.set :n :<leader>b :<cmd>Buffers<cr>)
;
;
;(require :ks.misc.fcitx)
;(require :ks.misc.hexokinase)
;(require :ks.misc.latex-to-unicode)
;(require :ks.misc.prettier)
;;;(require :ks.misc.smoothie)
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
