(local {: spec : key} (require :ks.lib.lazy))

(local formatters_by_ft {:python [:black]
                         :just [:just]
                         :nix [:alejandra]
                         :fennel [:fnlfmt]
                         :tex [:latexindent]
                         :typst [:typstfmt]})

(local format-args {:timeout_ms 500 :lsp_fallback true})

(fn with-conform [f]
  #(f (require :conform) (require :conform.util)))

(fn custom-formatters [conform/util]
  {:latexindent {:cwd (conform/util.root_file [:.latexindent.yaml])
                 :prepend_args [:-m :-l]}})

(fn config [conform conform/util]
  (conform.setup {:formatters (custom-formatters conform/util)
                  : formatters_by_ft
                  :format_on_save format-args}))

(local keys [(key :<leader>f (with-conform #($.format format-args)))])

(spec :stevearc/conform.nvim {:tag :v5.1.0
                              :config (with-conform config)
                              : keys})

