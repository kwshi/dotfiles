(local lsp-status (require :lsp-status))

(fn format-callback []
  (vim.lsp.buf.formatting_sync nil 1000))

;; TODO filter formatters to disable svelte/typescript formatting (use prettier
;; instead)
(fn default-on-attach [client bufnr]
  (do
    (lsp-status.on_attach client)
    (vim.api.nvim_create_autocmd [:BufWritePre] format-callback)
    (vim.keymap.set :<leader><leader> vim.lsp.buf.hover)
    (vim.keymap.set :<leader>d vim.lsp.buf.definition)
    (vim.keymap.set :<leader>r vim.lsp.buf.references)
    (vim.keymap.set :<leader>t vim.lsp.buf.type_definition)))

{: default-on-attach}
