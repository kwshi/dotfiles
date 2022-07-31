(local tectonic-opts
  ["--keep-logs" "--synctex" "-Zshell-escape"])

(local latexmk-opts
  ["-shell-escape"
   "-verbose"
   "-file-line-error"
   "-synctex=1"
   "-interaction=nonstopmode"
   "-halt-on-error"])

(local list-envs
  [:example :subproblems :itemize :enumerate :spotlight])

(set vim.g.vimtex_compiler_method :latexmk)
(set vim.g.vimtex_compiler_tectonic {:options tectonic-opts})
(set vim.g.vimtex_compiler_latexmk_engines {:_ "-lualatex"})
(set vim.g.vimtex_compiler_latexmk {:build_dir "_build" :options latexmk-opts})
(set vim.g.vimtex_view_method :zathura)

(set vim.g.vimtex_quickfix_open_on_warning false)

(set vim.g.vimtex_format_enabled true)

(set vim.g.vimtex_mappings_disable {:i ["]]"]})
(set vim.g.vimtex_imaps_enabled false)

(set vim.g.vimtex_indent_on_ampersands false)
(set vim.g.vimtex_indent_lists list-envs)
(set vim.g.vimtex_indent_tikz_commands false)


;; lsp.texlab.setup {
;;   on_attach = make_on_attach {},
;;   settings = {
;;     texlab = {
;;       --auxDirectory = ".",
;;       --bibtexFormatter = "texlab",
;;       build = {
;;         executable = "tectonic",
;;         args = { "%f", "--synctex", "--keep-logs", "--keep-intermediates" },
;;         isContinuous = false
;;       },
;;       --chktex = {
;;       --  onEdit = false,
;;       --  onOpenAndSave = false
;;       --},
;;       --diagnosticsDelay = 300,
;;       --formatterLineLength = 80,
;;       --forwardSearch = {
;;       --  args = {}
;;       --}
;;     }
;;   }
;; }
;; lsp.digestif.setup(default_args)
;; cfgs.digestif = {
;;   default_config = {
;;     cmd = {'digestif'},
;;     filetypes = {'tex', 'bib'},
;;     root_dir = function(filename)
;;       return util.path.dirname(filename)
;;     end,
;;   },
;; }


