(fn parse [...]
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

{: parse}
