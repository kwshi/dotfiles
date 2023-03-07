(local ks/lsp (require :ks.lib.lsp))
(local lsp (require :lspconfig))

(lsp.pyright.setup {:on_attach ks/lsp.default-on-attach})

;; TODO file GH issue; pyproject.toml and var ignored
(vim.api.nvim_create_autocmd [:BufWritePre] {:pattern "*.py" :command :Black})

(set vim.g.black_fast 1)
(set vim.g.black_target_version :py310)

