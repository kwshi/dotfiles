(import-macros {: snippet} :ks.macro.snippet)

(local {: concat} (require :ks.lib.table))

(macro snippet-env [opt wide]
  (let [trig (.. (if wide :ENV :env) (if opt "'" ""))
        wide-nodes (if wide `[/ /] `[/])
        opt-nodes (if opt `["[" ($ 2) "]"] `[])
        opt-offset (if opt 1 0)]
    `(snippet ,trig ["\\begin{"
                     ($ 1)
                     "}"
                     ,opt-nodes
                     ,wide-nodes
                     "  "
                     ($ 0)
                     ,wide-nodes
                     "\\end{"
                     (& 1)
                     "}"])))

(macro snippet-cmd [[trig-base cmd] n-opt padding]
  (let [trig (.. (match padding
                   0 trig-base
                   1 (.. (-> (trig-base:sub 1 1) string.upper)
                         (trig-base:sub 2))
                   2 (trig-base:upper)
                   _ (assert-compile false
                                     "padding size must be one of 0, 1, 2"))
                 (string.rep "'" n-opt))
        index-arg (+ 1 n-opt)
        nodes-pad `[]
        nodes-opt `[]
        nodes-arg (if (= padding 0) `($$ ,index-arg)
                      `["  " ($$ ,index-arg) ($ 0)])]
    (for [i 1 padding]
      (table.insert nodes-pad `/))
    (for [i 1 n-opt]
      (table.insert nodes-opt `["[" ($ ,i) "]"]))
    `(snippet ,trig ["\\"
                     ,cmd
                     ,nodes-opt
                     "{"
                     ,nodes-pad
                     ,nodes-arg
                     ,nodes-pad
                     "}"])))

(concat [[(snippet :mm ["\\(" ($$ 1) "\\)"])
          ; want to do ($$ 0) here but can't (throws error).
          ; see possibly related, <https://github.com/L3MON4D3/LuaSnip/issues/398>
          (snippet :MM ["\\[" / "  " ($ 0) / "\\]"])
          (snippet :im ["\\item"])
          (snippet "im'" ["\\item[" ($ 1) "]"])
          (snippet :doc ["\\begin{document}" / / ($ 0) / / "\\end{document}"])
          (snippet :lit ["\\begin{itemize}" / "  " ($ 0) / "\\end{itemize}"])
          (snippet :up ["\\usepackage{" ($$ 1) "}"])
          (snippet :rp ["\\RequirePackage{" ($$ 1) "}"])
          (snippet "up'" ["\\usepackage[" ($$ 2) "]{" ($$ 1) "}"])
          (snippet "rp'" ["\\RequirePackage[" ($$ 2) "]{" ($$ 1) "}"])
          (snippet :env ["\\begin{"
                         ($ 1)
                         "}"
                         /
                         "  "
                         ($ 0)
                         /
                         "\\end{"
                         (& 1)
                         "}"])
          (snippet "env'" ["\\begin{"
                           ($ 1)
                           "}["
                           ($ 2)
                           "]"
                           /
                           "  "
                           ($ 0)
                           /
                           "\\end{"
                           (& 1)
                           "}"])]
         (icollect [trigger command (pairs {:it :textbf
                                            :bf :textbf
                                            :tt :texttt
                                            :sl :textsl
                                            :em :emph
                                            :tx :text
                                            :au :author
                                            :ti :title
                                            :da :date
                                            :pg :paragraph
                                            :sec :section
                                            :ssec :subsection
                                            :sssec :subsubsection
                                            :ssssec :subsubsubsection})]
           (snippet trigger ["\\" (.t command) "{" ($$ 1) "}"]))])
