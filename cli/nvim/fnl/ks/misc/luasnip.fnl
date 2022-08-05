(local ls (require :luasnip))

(ls.config.set_config
  {:update_events "TextChanged,TextChangedI"})

(fn map-si [key f] (vim.keymap.set :s key f) (vim.keymap.set :i key f))

(vim.keymap.set :i :<tab> ls.expand_or_jump)
(vim.keymap.set :s :<tab> #(ls.jump 1))
(vim.keymap.set :s :<c-tab> #(ls.jump -1))

(map-si :<c-n> #(ls.change_choice 1))
(map-si :<c-p> #(ls.change_choice -1))
