(local ks/lsp (require :ks.lib.lsp))
(local lsp (require :lspconfig))

(lsp.rust_analyzer.setup
  {:on_attach ks/lsp.default-on-attach
   :settings {:rust-analyzer {:procMacro {:enable true}}}})
