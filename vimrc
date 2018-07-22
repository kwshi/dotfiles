
set noautoindent nocindent nosmartindent

filetype on
filetype plugin on

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"set relativenumber
set number

set list
set listchars=space:.,tab:>>

set shiftwidth=4 tabstop=4 expandtab softtabstop=4

let g:UltiSnipsSnippetDirectories=['ultisnips']

set encoding=utf-8

syntax on
color gruvbox

set bg=dark

let g:Tex_ViewRule_pdf='mupdf'
let g:Tex_DefaultTargetFormat='pdf'

set laststatus=2


let g:Tex_SmartKeyBS = 0
let g:Tex_SmartKeyQuote = 0
let g:Tex_SmartKeyDot = 0

let g:tex_flavor = 'latex'

let g:Tex_CompileRule_pdf = 'lualatex --interaction=nonstopmode $*'

let g:Tex_GotoError=0

"let g:solarized_termcolors=256
"
