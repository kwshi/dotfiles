(local subscripts {:0 "₀"
                   :1 "₁"
                   :2 "₂"
                   :3 "₃"
                   :4 "₄"
                   :5 "₅"
                   :6 "₆"
                   :7 "₇"
                   :8 "₈"
                   :9 "₉"
                   :a "ₐ"
                   :m "ₘ"
                   :n "ₙ"
                   :+ "₊"
                   :- "₋"
                   := "₌"})

(local superscripts {:0 "⁰"
                     :1 "¹"
                     :2 "²"
                     :3 "³"
                     :4 "⁴"
                     :5 "⁵"
                     :6 "⁶"
                     :7 "⁷"
                     :8 "⁸"
                     :9 "⁹"})

(local bb {:R "ℝ" :C "ℂ"})

(local symbols {:in "∈"
                :infty "∞"
                :to "→"
                :rightarrow "→"
                :ge "≥"
                :geq "≥"
                :le "≤"
                :leq "≤"})

(fn substitute [pattern substitution]
  (vim.api.nvim_command (.. ":%sm/" pattern "/" substitution :/ge)))

(fn rextify []
  ;; inline math
  (substitute "\\$\\@<!\\$\\(\\([^$]\\|\\n\\)\\+\\)\\$\\$\\@!" "\\\\(\\1\\\\)")
  ;; singleton groups, preceded immediately by letters (add space to avoid fudging macro)
  (substitute "[A-Za-z]\\@={\\([0-9A-Za-z]\\)}" " \\1")
  ;; singleton groups, not preceded immediately by letters
  (substitute "[A-Za-z]\\@!{\\([0-9A-Za-z]\\)}" "\\1")
  (each [k v (pairs subscripts)]
    (substitute (.. "\\_s*_" k "\\_s*") v))
  (each [k v (pairs superscripts)]
    (substitute (.. "\\_s*\\^" k "\\_s*") v))
  (each [k v (pairs bb)]
    (substitute (.. "\\_s*\\\\mathbb{\\_s*" k "\\_s*}\\_s*") v))
  (each [k v (pairs symbols)]
    (substitute (.. "\\_s*\\\\" k "[A-Za-z]\\@!\\_s*") v)))

(vim.api.nvim_create_user_command :Rextify rextify {})
