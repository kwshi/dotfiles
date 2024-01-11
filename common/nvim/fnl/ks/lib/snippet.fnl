(local ls (require :luasnip))
(local ks/str (require :ks.lib.string))
(local ks/tab (require :ks.lib.table))

{:add (fn [filetype ...] (ls.add_snippets filetype (ks/tab.flatten [...])))
 :parse ls.parser.parse_snippet
 :parse-lines #(ls.parser.parse_snippet $1 (ks/str.unlines $2))
 :snippet ls.snippet
 :shorthand
 {:t ls.text_node
  :i ls.insert_node
  :f ls.function_node
  :s ls.snippet_node
  :d ls.dynamic_node}}

