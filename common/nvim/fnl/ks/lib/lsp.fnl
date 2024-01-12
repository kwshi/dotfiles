;(local lsp-status (require :lsp-status))
;
;(fn format-callback []
;  (vim.lsp.buf.formatting_sync nil 1000))
;
;;; NOT YET SUPPORTED IN CURRENT NVIM
;;; Never request typescript-language-server for formatting
;;;(vim.lsp.buf.format {:filter #(~= $.name :tsserver)})
;
;;; TODO filter formatters to disable svelte/typescript formatting (use prettier
;;; instead)
;(fn default-on-attach [client bufnr]
;  (lsp-status.on_attach client)
;  (if (not= client.name :tsserver)
;      (vim.api.nvim_create_autocmd [:BufWritePre] {:callback format-callback}))
;  (vim.keymap.set :n :<leader><leader> vim.lsp.buf.hover)
;  (vim.keymap.set :n :<leader>d vim.lsp.buf.definition)
;  (vim.keymap.set :n :<leader>r vim.lsp.buf.references)
;  (vim.keymap.set :n :<leader>t vim.lsp.buf.type_definition))

(fn format-filter [server]
  (and (not= server.name :tsserver) (not= server.name :svelte)
       (not= server.name :astro)))

(local on-attach
       (fn [client buffer]
         (let [opts {:noremap true :silent true : buffer}
               format (fn [async]
                        (vim.lsp.buf.format {: async
                                             :bufnr buffer
                                             :filter format-filter}))]
           (vim.keymap.set :n :<leader><leader> vim.lsp.buf.hover opts)
           ;;(vim.keymap.set :n :<leader>f #(format true) opts) ; handled by conform
           (vim.keymap.set :n :<leader>d vim.lsp.buf.definition opts)
           (vim.keymap.set :n :<leader>t vim.lsp.buf.type_definition opts)
           (vim.keymap.set :n :<leader>r vim.lsp.buf.references opts)
           (vim.keymap.set :n :<leader>n vim.lsp.buf.rename opts)
           (vim.api.nvim_create_autocmd [:BufWritePre]
                                        {:callback #(format false) : buffer}))))

{: on-attach}
