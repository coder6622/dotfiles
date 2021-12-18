" Fundamentals "{{{
" ---------------------------------------------------------------------
"
"
" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8
" stop loading config if it's on tiny or small
if !1 | finish | endif

set nocompatible
set wrap
set linebreak
set nolist
"Number
set number
set relativenumber
syntax enable
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf-8
set background=dark
set nobackup
set noswapfile
set hlsearch
set showcmd
set cmdheight=1
set laststatus=2
set scrolloff=9
"let loaded_matchparen = 1
set shell=fish
set backupskip=/tmp/*,/private/tmp/*

set cursorline


" incremental substitution (neovim)
if has('nvim')
	set inccommand=split
endif

set ignorecase
" Be smart when using tabs ;)
" indents
filetype plugin  indent on
set shiftwidth=1
set smarttab
set tabstop=4
set si "Smart indent
set autoindent
" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*

"}}}

" Highlights "{{{
" ---------------------------------------------------------------------
set cursorline
"set cursorcolumn

set mouse=n


" Set cursor line color on visual mode
highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40

highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

augroup BgHighlight
	autocmd!
	autocmd WinEnter * set cul
	autocmd WinLeave * set nocul
augroup END

if &term =~ "screen"
	autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
	autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif

"}}}

" File types "{{{
" ---------------------------------------------------------------------
" JavaScript
au BufNewFile,BufRead *.es6 setf javascript
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
au BufNewFile,BufRead *.jsx setf javascriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.mdx set filetype=markdown
" Flow
au BufNewFile,BufRead *.flow set filetype=javascript
" Fish
au BufNewFile,BufRead *.fish set filetype=fish
au BufNewFile,BufRead *.html set filetype=html
au BufNewFile,BufRead *.css set filetype=css
au BufNewFile,BufRead *.scss set filetype=scss


set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md
autocmd FileType coffee setlocal shiftwidth=2 tabstop=2 autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
"}}}

" Imports "{{{
" ---------------------------------------------------------------------
runtime ./plug.vim
runtime ./maps.vim
"}}}

" Syntax theme "{{{
" ---------------------------------------------------------------------

" true color
if exists("&termguicolors") && exists("&winblend")
	syntax enable
	set termguicolors
	set winblend=0
	set wildoptions=pum
	set pumblend=5
	set background=dark
	let g:onedark_style = 'cool'
	colorscheme onedark
endif



