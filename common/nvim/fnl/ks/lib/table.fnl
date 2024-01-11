(fn append! [a b]
  (each [_ val (ipairs b)]
    (table.insert a val)))

(fn append [a b]
  (doto [] (append! a) (append! b)))

(fn concat! [init tables]
  (each [_ table (ipairs tables)]
    (append! init table)))

(fn concat [tables]
  (doto [] (concat! tables)))

(fn flat-map [tables f]
  (doto [] (#(each [_ t (ipairs tables)]
               (append! $ (f t))))))

(fn flatten [tables]
  (flat-map tables #$))

(fn map [a f]
  (doto [] (#(each [_ val (ipairs a)]
               (table.insert $ (f val))))))

(fn map-pairs [a f]
  (doto [] (#(each [k v (pairs a)]
               (table.insert $ (f k v))))))

{: append! : append : concat! : concat : flatten : flat-map : map : map-pairs}
