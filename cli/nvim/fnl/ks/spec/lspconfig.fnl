(local {: spec} (require :ks.lib.lazy))
(local {:on-attach on_attach} (require :ks.lib.lsp))

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
                   (lsp.hls.setup {: on_attach})))})
