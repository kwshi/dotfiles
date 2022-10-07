(local lsp (require :lspconfig))
(local ks/lsp (require :ks.lib.lsp))

(local ts-path "/home/kshi/.pnpm-global/node_modules/typescript/lib/tsserverlibrary.js")

(vim.api.nvim_create_autocmd
  [:BufRead :BufEnter]
  {:pattern :*.astro
   :command "setfiletype astro"})

(lsp.astro.setup
  {:on_attach ks/lsp.default-on-attach
   :init_options
   {:typescript {:serverPath ts-path}}})
