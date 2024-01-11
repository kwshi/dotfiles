(local {: spec} (require :ks.lib.lazy))
(spec :NvChad/nvim-colorizer.lua
      {:config #(let [colorizer (require :colorizer)]
                  (colorizer.setup {:user_default_options {:hsl_fn true}}))})
