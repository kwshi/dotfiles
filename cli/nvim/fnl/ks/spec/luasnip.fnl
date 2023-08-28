(local {: spec} (require :ks.lib.lazy))
(spec :L3MON4D3/LuaSnip
      {:dependencies [:julia-vim]
       :config #(let [ls (require :luasnip)
                      map-si (fn [key f]
                               (vim.keymap.set :s key f)
                               (vim.keymap.set :i key f))]
                  (ls.config.set_config {:update_events "TextChanged,TextChangedI"
                                         :store_selection_keys :<tab>})
                  (vim.keymap.set :i :<tab>
                                  #(if (ls.expand_or_locally_jumpable)
                                       (ls.expand_or_jump)
                                       (vim.api.nvim_feedkeys "\t" :nt true)))
                  (vim.keymap.set :s :<tab> #(ls.jump 1))
                  (vim.keymap.set :s :<c-tab> #(ls.jump -1))
                  (map-si :<c-n> #(ls.change_choice 1))
                  (map-si :<c-p> #(ls.change_choice -1))
                  (require :ks.snippet.tex)
                  (ls.add_snippets :all
                                   (icollect [k v (pairs (vim.fn.julia_latex_symbols#get_dict))]
                                     (ls.snippet {:trig k :wordTrig false}
                                                 (ls.text_node v)))))})
