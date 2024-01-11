(local ks/lsp (require :ks.lib.lsp))
(local lsp (require :lspconfig))

(lsp.julials.setup {:on_attach ks/lsp.default-on-attach})
