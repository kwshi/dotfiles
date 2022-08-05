(local ks/snip (require :ks.lib.snippet))
(local ks/str  (require :ks.lib.string))
(local ks/tab  (require :ks.lib.table))

(macro parse [...]
  `(let [ls# (require :luasnip)]
  ,(icollect
    [_ token (ipairs [...])]
    (match token
      (where [label] (sym? token))
      (match label
        "\\" `(ls#.text_node ["" ""])
        (where _ (label:find "^[$&]%d+$"))
        (match (label:sub 1 1)
          :& `(ls#.function_node (fn [[[a#]]] a#) ,(tonumber (label:sub 2)))
          :$ `(ls#.insert_node ,(tonumber (label:sub 2))))
        _ `(ls#.text_node ,token))
      (where _ (= (type token) :string)) `(ls#.text_node ,token)
      _ (assert-compile false "invalid token type" token)))))

;;(macrodebug (parse
;;  "\\begin{" !1 "}" \\
;;  "  " !0 \\
;;  "\\end{" ?1 "}"))

(local s ks/snip.shorthand)

(fn snippet-list [key env opts large]
  (let [ls ks/snip.shorthand trig (.. (if large (string.upper key) key) (if opts "'" ""))]
    (ks/snip.snippet
      trig
      (ks/tab.flatten
        [[(s.t (ks/str.<> "\\begin{" env "}"))]
         (if opts [(s.t "[") (s.i 1) (s.t "]")] [])
         (if large [(s.t ["" "" "  "])] [(s.t ["" "  "])])
         [(s.i 0)]
         (if large [(s.t ["" ""])] [])
         [(s.t ["" (ks/str.<> "\\end{" env "}")])]
         ]))))

(snippet-list :li :itemize false false)

(ks/snip.add
  :tex
  (ks/tab.flatten (icollect
    [key env (pairs {:li :itemize
                     :le :enumerate
                     :ld :description
                     :tk :tikzpicture
                     :ct :center})]
    [(snippet-list key env false false)
     (snippet-list key env false true)
     (snippet-list key env true false)
     (snippet-list key env true true)]))
  (icollect
    [trig cmd (pairs {:it :textit
                      :bf :textbf
                      :em :emph
                      :tx :text
                      :pg :paragraph
                      :sec :section
                      :ssec :subsection
                      :sssec :subsubsection
                      :ssssec :subsubsubsection})]
    (ks/snip.snippet trig [(s.t (ks/str.<> "\\" cmd "{")) (s.i 1) (s.t "}")]))
  [(ks/snip.snippet :ii (s.t "\\item "))
   (ks/snip.snippet "ii'" [(s.t "\\item[") (s.i 1) (s.t "] ")])
   (ks/snip.snippet :dc [(s.t "\\documentclass{") (s.i 1) (s.t "}")])
   (ks/snip.snippet "dc'" [(s.t "\\documentclass[") (s.i 1) (s.t "]{") (s.i 2) (s.t "}")])
   (ks/snip.snippet :gr [(s.t "{") (s.i 1) (s.t "}")])
   (ks/snip.snippet :mm [(s.t "\\(") (s.i 1) (s.t "\\)")])
   (ks/snip.snippet :MM [(s.t ["\\[" "  "]) (s.i 0) (s.t ["" "\\]"])])
   (ks/snip.snippet :env (parse "\\begin{" $1 "}" \ "  " $0 \ "\\end{" &1 "}" ))
   (ks/snip.snippet "env'" (parse "\\begin{" $1 "}[" $2 "]" \ "  " $0 \ "\\end{" &1 "}" ))
   (ks/snip.snippet :ENV (parse "\\begin{" $1 "}" \ \ "  " $0 \ \ "\\end{" &1 "}" ))
   (ks/snip.snippet "ENV'" (parse "\\begin{" $1 "}[" $2 "]" \ \ "  " $0 \ \ "\\end{" &1 "}" ))
   ])
