(local {: spec} (require :ks.lib.lazy))
(spec :lervag/vimtex
      {:config #(let [tectonic-opts [:--keep-logs :--synctex :-Zshell-escape]
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
                  (set vim.g.vimtex_compiler_tectonic {:options tectonic-opts})
                  (set vim.g.vimtex_compiler_latexmk_engines
                       {:_ :-lualatex
                        :pdflatex :-pdflatex
                        :lualatex :-lualatex})
                  (set vim.g.vimtex_compiler_latexmk
                       {:out_dir :_build :options latexmk-opts})
                  (set vim.g.vimtex_view_method :zathura)
                  (set vim.g.vimtex_quickfix_open_on_warning false)
                  (set vim.g.vimtex_format_enabled true)
                  (set vim.g.vimtex_mappings_disable {:i ["]]"]})
                  (set vim.g.vimtex_imaps_enabled false)
                  (set vim.g.vimtex_indent_on_ampersands false)
                  (set vim.g.vimtex_indent_lists list-envs)
                  (set vim.g.vimtex_indent_tikz_commands false))})
