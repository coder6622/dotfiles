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
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf-8
set nobackup
set noswapfile
set hlsearch
set showcmd
set cmdheight=1
set laststatus=2
set scrolloff=9
"let loaded_matchparen = 1
set backupskip=/tmp/*,/private/tmp/*

set cursorline


" incremental substitution (neovim)
if has('nvim')
	set inccommand=split
endif

if has ("syntax")
  syntax on
endif

set ignorecase
" Be smart when using tabs ;)
" indents
filetype plugin  indent on
set shiftwidth=2
set smarttab
set tabstop=5
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
	autocmd BufEnter * if bufname('') !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
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
endif



let g:onedark_config = {
  \ 'style': 'deep',
  \ 'toggle_style_key': '<leader>ts',
  \ 'ending_tildes': v:true,
  \ 'diagnostics': {
    \ 'darker': v:false,
    \ 'background': v:false,
  \ },
\ }
	colorscheme onedark

" INFO:nerd tree setup
let NERDTreeShowHidden=1
map <silent> <F5> :NERDTreeToggle<CR>
map <silent> <F6> :NERDTreeRefreshRoot<CR>

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif




"NOTE:========================MAPS===================="
" Description: Keymaps

" NERD tree configuration
nnoremap F :NERDTreeFind<CR>


nnoremap <S-C-p> "0p
" Delete without yank
nnoremap <leader>d "_d
nnoremap x "_x

" Increment/decrement
nnoremap + <C-a>
nnoremap - <C-x>

" Delete a word backwards
nnoremap dw vb"_d

" Select all
nmap <C-a> gg<S-v>G

nnoremap <silent> <A-k> /<C-R><C-W><CR>
map <silent> <A-h> :nohlsearch<CR>

" Save with root permission
command! W w !sudo tee > /dev/null %

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

"-----------------------------
" Tabs

" Open current directory
nmap te :tabedit 
nmap tn :tabnew<Return>
nmap tc :tabclose<Return>
nmap tp :tabprev<Return>
nmap <Tab> :tabnext<Return>




"------------------------------
" Windows
tnoremap <Esc><Esc> <C-\><C-n>

" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

"resize  split
noremap <silent> <S-h> :vertical resize -5<CR>
noremap <silent> <S-l> :vertical resize +5<CR>
noremap <silent> <S-k> :resize +5<CR>
noremap <silent> <S-j> :resize -5<CR>
" Move window
map s<left> <C-w>h
map s<up> <C-w>k
map s<down> <C-w>j
map s<right> <C-w>l
map <C-h> <C-w>h
map <C-k> <C-w>k
map <C-j> <C-w>j
map <C-l> <C-w>l
" Resize window
nmap <C-w><left> <C-w><
nmap <C-w><right> <C-w>>
nmap <C-w><up> <C-w>+
nmap <C-w><down> <C-w>-

nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" nnoremap <silent> <C-S-Up> :exe "resize " . (winheight(0) * 3/2)<CR>
" nnoremap <silent> <C-S-Down> :exe "resize " . (winheight(0) * 2/3)<CR>
" nnoremap <silent> <C-S-Left> :exe "vertical resize " . (winheight(0) * 3/2)<CR>
" nnoremap <silent> <C-S-Right> :exe "vertical resize " . (winheight(0) * 2/3)<CR>

"prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#config#single_quote = '--single-quote'
let g:prettier#config#trailing_comma = 'all'
let g:prettier#config#bracket_spacing = '--bracket-spacing'
let g:prettier#config#bracket_same_line = '--bracket-same-line'


