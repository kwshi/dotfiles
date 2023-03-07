(local ks/lsp (require :ks.lib.lsp))
(local lsp (require :lspconfig))

(fn on-attach [client bufnr]
  (ks/lsp.default-on-attach client bufnr)
  (if client.config.flags
    (set client.config.flags.allow_incremental_sync true)))

(lsp.elmls.setup {:on_attach ks/lsp.default-on-attach})
