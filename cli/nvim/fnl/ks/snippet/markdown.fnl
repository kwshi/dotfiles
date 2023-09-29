(import-macros {: snippet} :ks.macro.snippet)

[(snippet :mm ["$" ($$ 1) "$"])
 (snippet :MM ["$$" / "  " ($ 0) / "$$"])
 (snippet :it ["_" ($$ 1) "_"])
 (snippet :bf ["**" ($$ 1) "**"])
 (snippet :cb ["```" ($$ 1) / ($ 0) / "```"])]
