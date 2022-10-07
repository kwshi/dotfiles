(local tex {})

(fn symbol-name [s]
  (assert-compile (sym? s) "`symbol-name` must be called on a symbol" s)
  (tostring s))

(fn symbol-dot [s k]
  (sym (.. (symbol-name s) "." k)))

(fn parse-node [ls add token]
  (fn ls/ [key ...] `(,(symbol-dot ls key) ,...))
  (match token

    ; bare strings are text nodes
    (where _ (= (type token) :string))
    (add (ls/ :text_node token))

    ; special underscore or nil tokens are no-op (blank)
    (where _ (and (sym? token) (or (= (tostring token) :_) (= (tostring token) :nil))))
    (do)

    ; special backslash token is newline
    (where _ (and (sym? token) (= (symbol-name token) :/)))
    (add (ls/ :text_node ["" ""]))

    ; sequence of tokens (for convenient concatMap-like syntax)
    (where _ (sequence? token))
    (each [_ t (ipairs token)] (parse-node ls add t))

    ; node constructor forms with arguments
    (where [k & args] (list? token))
    (add
      (do
        (assert-compile (sym? k) "constructor token must be a symbol" token)
        (match [(symbol-name k) args]
          ; `($ n)` insert node (TODO handle placeholder)
          [:$ [index]]
          (do (assert-compile (= (type index) :number) "`$` argument must be a number literal" token)
            (ls/ :insert_node index))

          ; `($$ n)` insert node defaulting to current selection
          [:$$ [index]]
          (do (assert-compile (= (type index) :number) "`$$` argument must be a number literal" token)
            (ls/ :dynamic_node index
                 `(fn [# parent#]
                    ,(ls/ :snippet_node `nil
                          ;; empty-check needed per <https://github.com/L3MON4D3/LuaSnip/issues/511>;
                          ;; can simplify once <https://github.com/L3MON4D3/LuaSnip/pull/512> is merged
                          (ls/ :insert_node 1 `parent#.env.SELECT_RAW)))))

          ; `(& n)` function node referencing an insert node
          [:& [index]]
          (do (assert-compile (= (type index) :number) "`&` argument must be a number literal" token)
            (ls/ :function_node `#(. (. $ 1) 1) index))

          ; `(_ <expr>)` dynamic node (`expr` is any expression producing a luasnip node)
          [:_ [expr]] expr

          ; luasnip node constructor shorthands
          [:.t [text]] (ls/ :text_node text)
          [:.i [pos]] (ls/ :insert_node pos)
          [:.f [func deps ?opts]] (ls/ :function_node func deps ?opts)
          [:.c [pos nodes]] (ls/ :choice_node pos nodes)
          [:.d [pos func deps ?opts]] (ls/ :dynamic_node pos func deps ?opts)

          _ (assert-compile false "unrecognized node constructor" token)
          )))

    _ (assert-compile false "unrecognized node token" token)))

(fn parse-body [ls tokens]
  (local nodes [])
  (each [_ token (ipairs tokens)]
    (parse-node ls #(table.insert nodes $) token))
  nodes)

(fn snippet [key ...]
  (assert-compile (or (sym? key) (= (type key) :string) (= (type key) :table))
                  "expected string/symbol (trigger) or table (trigger + options)" key)
  `(let [ls# (require :luasnip)]
  ,(match [...]
    [opts nodes]
    (do (assert-compile (and (table? opts) (not (sequence? opts)))
                        "expected non-sequence (dictionary) table of options" opts)
      (assert-compile (sequence? nodes) "expected sequence of nodes" nodes)
      `(ls#.snippet ,key ,(parse-body `ls# nodes) opts))

    [nodes]
    (do
      (assert-compile (sequence? nodes) "expected sequence of nodes" nodes)
      `(ls#.snippet ,key ,(parse-body `ls# nodes)))

    _ (assert-compile false "expecting nodes sequence or options table"))))

(fn cartesian-product [terms]
  (local getters [])
  (var count 1)
  (each [i term (ipairs terms)]
    (let [offset count
          size (length term)
          get #(. term (-> $ (- 1) (/ offset) (math.floor) (% size) (+ 1)))]
      (set count (* count size))
      (tset getters i get)))

  (local tuples [])
  (for [key 1 count]
    (tset tuples key (icollect [_ get (ipairs getters)] (get key))))
  tuples)

(fn let* [bindings body]
  (assert-compile (sequence? bindings)
                  "expected bindings sequence" bindings)
  (assert-compile (sequence? body)
                  "expected sequence of body expressions" body)
  (assert-compile (-> (length bindings) (% 2) (= 0))
                  "expected even number of items (parameter + values pairs)" bindings)

  (local patterns [])
  (local terms [])
  (for [i 1 (length bindings) 2]
    (local pattern (. bindings i))
    (local term (. bindings (+ i 1)))
    (local term* (macroexpand term))
    (assert-compile (sequence? term*)
                    "expected sequence of parameter values (after macro expansion)" term)

    (table.insert patterns pattern)
    (table.insert terms term*))

  (local results `[])
  (each [_ expr (ipairs body)]
    (each [key tuple (ipairs (cartesian-product terms))]
      (local binds [])
      (each [i elem (ipairs tuple)]
        (table.insert binds (. patterns i))
        (table.insert binds elem))
      (table.insert results `(let ,binds ,expr))))
  results)

(fn map* [terms body]
  (local terms* (macroexpand terms))
  (assert-compile (sequence? terms*)
                  "expected product terms sequence (after macro expansion)" terms)
  (assert-compile (sequence? body)
                  "expected sequence of body expressions" body)

  (local results `[])
  (each [_ expr (ipairs body)]
    (assert-compile (list? expr) "expected function call expression" expr)
    (each [_ tuple (ipairs (cartesian-product terms*))]
      (local spliced `())
      (each [_ elem (ipairs expr)] (table.insert spliced elem))
      (each [_ elem (ipairs tuple)] (table.insert spliced elem))
      (table.insert results spliced)))
  results)

(fn generate* [...]
  (local results [])
  (each [_ entry (ipairs [...])]
    (local entry* (macroexpand entry))
    (assert-compile (sequence? entry*)
                    "expected sequence of generated expressions" entry)
    (each [_ expr (ipairs entry*)] (table.insert results expr)))
  results)


{: snippet
 : generate*
 : map*
 : let*}
