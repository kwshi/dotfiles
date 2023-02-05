;(import-macros  :ks.lib.snippet.macro)
(local ks/snip (require :ks.lib.snippet))

;;(ks/snip.add
;;  :all
;;  (icollect
;;    [k v (pairs (vim.fn.julia_latex_symbols#get_dict))]
;;    (ks/snip.snippet k (ks/snip.shorthand.t v))))
