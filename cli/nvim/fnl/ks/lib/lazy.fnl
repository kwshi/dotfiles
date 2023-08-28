(fn spec [plugin opts]
  (let [tbl [plugin]]
    (each [k v (pairs (or opts {}))]
      (tset tbl k v))
    tbl))

(fn key [lhs rhs opts]
  (let [tbl [lhs rhs]
        opts (or opts {})]
    (each [k v (pairs opts)]
      (tset tbl k v))
    tbl))

{: spec : key}
