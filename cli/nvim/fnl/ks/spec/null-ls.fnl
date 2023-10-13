(local {: spec} (require :ks.lib.lazy))
(local {:on-attach on_attach} (require :ks.lib.lsp))

(spec :jose-elias-alvarez/null-ls.nvim
      {:dependencies [:plenary.nvim]
       :config #(let [nl (require :null-ls)]
                  (nl.setup {:sources [;nl.builtins.diagnostics.alex
                                       ;nl.builtins.formatting.alejandra
                                       nl.builtins.formatting.black
                                       nl.builtins.formatting.fnlfmt
                                       nl.builtins.formatting.just
                                       (nl.builtins.formatting.prettier.with {:extra_filetypes [:astro
                                                                                                :svelte]})
                                       (nl.builtins.formatting.latexindent.with {:args [:-m
                                                                                        :-l
                                                                                        "-"]})]
                             : on_attach}))})
