(local {: spec} (require :ks.lib.lazy))
(local {:on-attach on_attach} (require :ks.lib.lsp))

; https://github.com/aca/emmet-ls#example-configuration
(local capabilities (vim.lsp.protocol.make_client_capabilities))
(set capabilities.textDocument.completion.completionItem.snippetSupport true)

(spec :neovim/nvim-lspconfig
      {:config (fn []
                 (let [lsp (require :lspconfig)]
                   (lsp.pyright.setup {: on_attach})
                   (lsp.tsserver.setup {: on_attach})
                   (lsp.ccls.setup {: on_attach})
                   (lsp.gopls.setup {: on_attach})
                   (lsp.rust_analyzer.setup {: on_attach})
                   (lsp.ocamllsp.setup {: on_attach})
                   (lsp.astro.setup {: on_attach})
                   (lsp.svelte.setup {: on_attach})
                   (lsp.nil_ls.setup {: on_attach})
                   ;(lsp.fennel-ls.setup {: on_attach})
                   (lsp.hls.setup {: on_attach})
                   (lsp.emmet_ls.setup {: capabilities
                                        : on_attach
                                        :init_options {:html {:options {:bem.enabled true}}}})))})
