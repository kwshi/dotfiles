(fn config [ts/p ts/c]
  (tset (ts/p.get_parser_configs) :hy
        {:install_info {:url "~/hacks/tree-sitter-hy" :files [:src/parser.c]}})
  (ts/c.setup {:highlight {:enable true}
               :auto_install true
               :playground {:enable true}}))

(local {: spec} (require :ks.lib.lazy))
(spec :nvim-treesitter/nvim-treesitter
      {:dependencies [:nvim-treesitter/playground]
       :config #(config (require :nvim-treesitter.parsers)
                        (require :nvim-treesitter.configs))})
