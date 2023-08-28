(local {: spec} (require :ks.lib.lazy))
(spec :nvim-treesitter/nvim-treesitter
      {:config #(let [ts (require :nvim-treesitter.configs)]
                  (ts.setup {:highlight {:enable true} :auto_install true}))})
