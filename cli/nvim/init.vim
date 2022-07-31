
"let g:python3_host_prog = $HOME . '/.venv/bin/python'

call plug#begin('~/.local/share/nvim/site/plug')

Plug 'rktjmp/hotpot.nvim'
Plug 'bakpakin/fennel.vim'

Plug 'lilydjwg/fcitx.vim'

Plug 'nvim-lua/lsp-status.nvim'

Plug 'gruvbox-community/gruvbox'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'
"Plug 'nvim-lua/completion-nvim'

"Plug 'norcalli/nvim-colorizer.lua'

Plug 'psliwka/vim-smoothie'

Plug 'prettier/vim-prettier'
Plug 'evanleck/vim-svelte', { 'branch': 'main' }

Plug 'kana/vim-textobj-user'
Plug 'glts/vim-textobj-comment'

Plug 'cespare/vim-toml'

Plug 'JuliaEditorSupport/julia-vim'

Plug 'vmchale/just-vim'

Plug 'lervag/vimtex'

Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

Plug 'ntpeters/vim-better-whitespace'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'sirtaj/vim-openscad'

Plug 'psf/black'
"Plug 'averms/black-nvim'

Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
Plug 'kdheepak/lazygit.nvim'

Plug 'chrisbra/unicode.vim'

Plug 'tbastos/vim-lua'
"Plug 'willelz/teastylua.nvim'

Plug 'rhysd/vim-clang-format'

Plug 'folke/trouble.nvim'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'glacambre/firenvim'

"Plug 'subnut/nvim-ghost.nvim'

call plug#end()

lua require 'hotpot'.setup { compiler = { modules = { correlate = true } } }
lua require 'ks'

filetype off
set rtp+=~/hacks/tater/extra/nvim
filetype on


"let g:completion_enable_auto_popup = 0
"let g:completion_enable_server_trigger = 0


au FileType c,cpp ClangFormatAutoEnable

"imap <silent> <tab> <Plug>(completion_smart_tab)
"imap <silent> <s-tab> <Plug>(completion_smart_s_tab)

"au BufWritePre *.lua lua Teastylua()
"let g:teastylua_options = '--column-width=80'

let g:julia_indent_align_brackets = 0
let g:julia_indent_align_funcargs = 0

let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0
let g:strip_only_modified_lines = 0
