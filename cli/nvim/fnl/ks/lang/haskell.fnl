(local ks/lsp (require :ks.lib.lsp))
(local lsp (require :lspconfig))

(lsp.hls.setup
  {:on_attach ks/lsp.default-on-attach
   :cmd ["haskell-language-server-wrapper" "--lsp"]
   :single_file_support true})

(require :ks.snippet.haskell)
