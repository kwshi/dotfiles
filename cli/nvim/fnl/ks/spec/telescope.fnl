(local {: spec : key} (require :ks.lib.lazy))

(fn config []
  (let [telescope (require :telescope)]
    (telescope.setup)))

(fn builtin [f]
  #(f (require :telescope.builtin)))

(local keys
       [(key :<leader>b (builtin #($.buffers)))
        (key :<leader>E (builtin #($.diagnostics)))
        (key :<leader>l (builtin #($.find_files)))
        (key :<leader>L (builtin #($.git_files {:show_untracked true})))])

(spec :nvim-telescope/telescope.nvim
      {:tag :0.1.1 :lazy false :dependencies [:plenary.nvim] : config : keys})
