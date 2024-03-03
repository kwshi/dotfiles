(import-macros {: snippet} :ks.macro.snippet)

(local {: concat} (require :ks.lib.table))

(concat [[(snippet :mm ["$" ($$ 1) "$"])
          (snippet :MM ["$" / "  " ($ 0) / "$"])]])

