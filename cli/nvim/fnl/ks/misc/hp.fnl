(local hotpot/api/diagnostics (require :hotpot.api.diagnostics))

;(local allowed-globals)

(fn hotpot-eval-mode []
  (hotpot/api/diagnostics.set-options 0 {:env :_COMPILER} :eval))

(fn hotpot-eval-mode-prompt []
  (vim.ui.input
    {:prompt "Macro mode runs arbitrary code. Confirm (y/n)? "
     :highlight #[]}
  #(if (= $ :y) (hotpot-eval-mode))))

(vim.api.nvim_create_user_command
  :HotpotEvalMode
  hotpot-eval-mode-prompt
  {})
