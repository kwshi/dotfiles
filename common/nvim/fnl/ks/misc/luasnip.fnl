(local ls (require :luasnip))

(ls.config.set_config
  {:update_events "TextChanged,TextChangedI"
   :store_selection_keys :<tab>})

(fn map-si [key f] (vim.keymap.set :s key f) (vim.keymap.set :i key f))

;;(vim.keymap.set :i :<tab> "<plug>luasnip-expand-or-jump")
(vim.keymap.set
  :i :<tab>
  #(if (ls.expand_or_locally_jumpable)
     (ls.expand_or_jump)
     (vim.api.nvim_feedkeys "\t" :nt true)))
;;(vim.keymap.set :i :<tab> ls.expand_or_jump)
;;(vim.keymap.set :i :<tab> #(if (vim.fn.L)))
(vim.keymap.set :s :<tab> #(ls.jump 1))
(vim.keymap.set :s :<c-tab> #(ls.jump -1))

(map-si :<c-n> #(ls.change_choice 1))
(map-si :<c-p> #(ls.change_choice -1))

(require :ks.snippet.all)

