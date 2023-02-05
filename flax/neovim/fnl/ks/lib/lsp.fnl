(local lsp-status (require :lsp-status))

(fn format-callback []
  (vim.lsp.buf.formatting_sync nil 1000))

;; NOT YET SUPPORTED IN CURRENT NVIM
;; Never request typescript-language-server for formatting
;;(vim.lsp.buf.format {:filter #(~= $.name :tsserver)})

;; TODO filter formatters to disable svelte/typescript formatting (use prettier
;; instead)
(fn default-on-attach [client bufnr]
  (lsp-status.on_attach client)
  (if (~= client.name :tsserver)
    (vim.api.nvim_create_autocmd [:BufWritePre] {:callback format-callback}))
  (vim.keymap.set :n :<leader><leader> vim.lsp.buf.hover)
  (vim.keymap.set :n :<leader>d vim.lsp.buf.definition)
  (vim.keymap.set :n :<leader>r vim.lsp.buf.references)
  (vim.keymap.set :n :<leader>t vim.lsp.buf.type_definition))

{: default-on-attach}
