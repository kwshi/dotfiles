vim.opt.runtimepath:prepend (vim.fn.stdpath 'data' .. '/lazy/hotpot.nvim')
vim.opt.runtimepath:prepend (vim.fn.stdpath 'data' .. '/lazy/lazy.nvim')

require 'hotpot'.setup {
  compiler = {
    modules = { correlate = true },
    macros = { env = '_COMPILER' },
  },
}
require 'ks'
