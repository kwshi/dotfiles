local cfgs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

cfgs.digestif = {
  default_config = {
    cmd = {'digestif'},
    filetypes = {'tex', 'bib'},
    root_dir = function(filename)
      return util.path.dirname(filename)
    end,
  },
}


local lsp = require 'lspconfig'

local default = function(val, def)
  if val == nil then return def
  else return val
  end
end

local make_on_attach = function(opts)
  opts.fmt = default(opts.fmt, true)
  opts.incr = default(opts.incr, false)

  return function(client, buf)
    local set_key = function(k, v) 
      vim.api.nvim_buf_set_keymap(buf, 'n', k, v, {
        noremap = true,
        silent = true,
      })
    end
    set_key('<leader><leader>', '<Cmd>lua vim.lsp.buf.hover()<CR>') 
    set_key('<leader>d', '<Cmd>lua vim.lsp.buf.definition()<CR>') 
    set_key('<leader>r', '<Cmd>lua vim.lsp.buf.references()<CR>') 
    set_key('<leader>t', '<Cmd>lua vim.lsp.buf.type_definition()<CR>') 
    if opts.fmt then
      vim.api.nvim_exec('au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)', false)
    end

    if client.config.flags then
      if opts.incr then
        client.config.flags.allow_incremental_sync = true
      end
    end

  end
end

local default_args = { on_attach = make_on_attach {} }

lsp.tsserver.setup {
  on_attach = make_on_attach { fmt = false }
}
lsp.elmls.setup {
  on_attach = make_on_attach { incr = true }
}

lsp.ocamllsp.setup(default_args)
lsp.svelte.setup(default_args)
lsp.pyls.setup(default_args)
lsp.gopls.setup(default_args)
lsp.rust_analyzer.setup {
  on_attach = make_on_attach {},
  settings = {
    ["rust-analyzer"] = {
      --assist = {
      --  importMergeBehavior = "last",
      --  importPrefix = "by_self",
      --},
      --cargo = {
      --  loadOutDirsFromCheck = true
      --},
      procMacro = {
        enable = true
      },
    }
  }
}
--lsp.texlab.setup {
--  on_attach = make_on_attach {},
--  settings = {
--    texlab = {
--      --auxDirectory = ".",
--      --bibtexFormatter = "texlab",
--      build = {
--        executable = "tectonic",
--        args = { "%f", "--synctex", "--keep-logs", "--keep-intermediates" },
--        isContinuous = false
--      },
--      --chktex = {
--      --  onEdit = false,
--      --  onOpenAndSave = false
--      --},
--      --diagnosticsDelay = 300,
--      --formatterLineLength = 80,
--      --forwardSearch = {
--      --  args = {}
--      --}
--    }
--  }
--}
--lsp.digestif.setup(default_args)
