
"let g:python3_host_prog = $HOME . '/.venv/bin/python'

call plug#begin('~/.local/share/nvim/site/plug')

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

set number termguicolors expandtab autochdir
set shiftwidth=2
set tabstop=2
set signcolumn=number
set wildmode=list:longest
set backupcopy=yes
set inccommand=nosplit
set mouse=a

set textwidth=80
set formatoptions-=t fo-=c fo-=r fo-=o
"set backup
"set completeopt=menu,noinsert


" for wrapping chinese text
set formatoptions+=mM

filetype off
set rtp+=~/hacks/tater/extra/nvim
filetype on

"set rtp+=/data/hacks/nvim-colorizer.lua

au FileType * set fo-=t fo-=c fo-=r fo-=o

let mapleader = ' '
"let g:completion_enable_auto_popup = 0
"let g:completion_enable_server_trigger = 0

nnoremap <space> <nop>
nnoremap <silent> <leader>F :GFiles<cr>
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>b :Buffers<cr>

au FileType c,cpp ClangFormatAutoEnable

"imap <silent> <tab> <Plug>(completion_smart_tab)
"imap <silent> <s-tab> <Plug>(completion_smart_s_tab)

"TODO file GH issue; pyproject.toml and var ignored
au BufWritePre *.py Black target_version=py310
let g:black_fast = 1
let g:black_target_version = "py310"

"au BufWritePre *.lua lua Teastylua()
"let g:teastylua_options = '--column-width=80'


silent! colorscheme gruvbox

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

let g:smoothie_speed_linear_factor = 30
let g:smoothie_speed_exponentiation_factor = 0.75

let g:latex_to_unicode_auto = 0
"let g:latex_to_unicode_file_types  = 'julia\|python\|haskell\|javascript\|typescript\|rust\|tex\|markdown'
let g:latex_to_unicode_file_types = '.*'
let g:latex_to_unicode_eager = 0
let g:latex_to_unicode_suggestions = 0

"let g:latex_to_unicode_keymap = 1

let g:Hexokinase_optInPatterns = 'full_hex,triple_hex,rgb,rgba,hsl,hsla,colour_names'
let g:Hexokinase_refreshEvents = ['TextChanged', 'TextChangedI', 'InsertLeave', 'BufRead']
let g:Hexokinase_highlighters = ['backgroundfull']

let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_tectonic = {'options': ['--keep-logs', '--synctex', '-Zshell-escape']}
let g:vimtex_compiler_latexmk_engines = {'_': '-lualatex'}
let g:vimtex_compiler_latexmk = {'build_dir': '_build', 'options': ['-shell-escape', '-verbose', '-file-line-error', '-synctex=1', '-interaction=nonstopmode', '-halt-on-error']}
let g:vimtex_view_method = 'zathura'
let g:vimtex_format_enabled = 1
let g:vimtex_indent_on_ampersands = 0
"let g:vimtex_indent_enabled = 0
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_mappings_disable = {'i': [']]']}
let g:vimtex_imaps_enabled = 0
let g:vimtex_indent_lists = ['example', 'subproblems', 'itemize', 'enumerate', 'spotlight']
let g:vimtex_indent_tikz_commands = 0

let g:julia_indent_align_brackets = 0
let g:julia_indent_align_funcargs = 0

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0
let g:strip_only_modified_lines = 0

let g:fcitx5_remote = 'fcitx5-remote'

lua require 'init'
