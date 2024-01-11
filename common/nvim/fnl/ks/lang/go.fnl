(local ks/lsp (require :ks.lib.lsp))
(local lsp (require :lspconfig))

(lsp.gopls.setup {:on_attach ks/lsp.default-on-attach})

