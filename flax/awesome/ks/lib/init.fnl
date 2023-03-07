(fn container [layout ...]
  (let [children [...]]
    (set children.layout layout)
    children))

(fn widget [class props ...]
  (let [w [...]]
    (set w.widget class)
    (each [k v (pairs props)] (tset w k v))
    w))

{: container
 : widget}
