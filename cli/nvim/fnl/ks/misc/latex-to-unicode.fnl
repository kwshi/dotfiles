(local ls (require :luasnip))

;; disable latextounicode's built-in tab completion hook; instead register
;; insert-mode latex sequences as snippets (below).  we manually re-enable
;; latextounicode's command-line mode mapping.
(set vim.g.latex_to_unicode_tab false)
;;(vim.keymap.set :c :<tab> #(vim.fn.LaTeXtoUnicode#CmdTab :<tab>))

(ls.add_snippets
  :all
  (icollect
    [k v (pairs (vim.fn.julia_latex_symbols#get_dict))]
    (ls.snippet {:trig k :wordTrig false} (ls.text_node v))))

;; other settings I used to have; no longer relevant when manually replacing tab
;; mode with snippets

;(set vim.g.latex_to_unicode_auto false)
;(set vim.g.latex_to_unicode_file_types ".*")
;(set vim.g.latex_to_unicode_eager false)
;(set vim.g.latex_to_unicode_suggestions false)

