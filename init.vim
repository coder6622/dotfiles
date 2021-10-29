call plug#begin('~/.config/nvim/plugged')
"Themes"
" Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'
" File Brower"
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons' "Icon file
Plug 'Xuyuanp/nerdtree-git-plugin' "Git
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"File search"
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Status"
Plug 'itchyny/lightline.vim'
"Equal live server
" Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
"Terminal Float"
"Coc"
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'jiangmiao/auto-pairs' "Auto pair
Plug 'AndrewRadev/tagalong.vim'
Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'maxmellon/vim-jsx-pretty'
"Debug"
Plug 'puremourning/vimspector'
"Manage branch git"
Plug 'tpope/vim-fugitive'
"Multi select"
" Plug 'terryma/vim-multiple-cursors'
Plug 'mg979/vim-visual-multi'
"Comment in Nvim"
Plug 'tpope/vim-commentary'
Plug 'Chiel92/vim-autoformat'
Plug 'ap/vim-css-color'
Plug 'ryanoasis/vim-devicons'
Plug 'lilydjwg/colorizer'
Plug 'guns/xterm-color-table.vim'
Plug 'Pocco81/AutoSave.nvim'
Plug 'sheerun/vim-polyglot'
" set background=dark  " for the light version
" set background=light
let g:one_allow_italics = 1 " I love italic for comments
" syntax on
colorscheme onedark
" colorscheme one
call plug#end()
source  ~/.config/nvim/Settings/nerdtree.vim
source  ~/.config/nvim/Settings/fzf.vim
source  ~/.config/nvim/Settings/terminal.vim
source  ~/.config/nvim/Settings/coc.vim
source  ~/.config/nvim/Settings/emmet.vim
" source  ~/.config/nvim/Settings/multiselect.vim
source  ~/.config/nvim/Settings/autosave.vim
" Leader
" let mapleader = " "
set smarttab
set backspace=2   " Backspace deletes like most programs in insert mode
set ai "Auto indent
set si "Smart indent
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
" set autoindent
set smartindent

set autoread

" Softtabs, 2 spaces
set tabstop=1
set shiftwidth=2
set shiftround
set expandtab

" Make it obvious where 80 characters is
set textwidth=90
set colorcolumn=+1
set cursorline
"set cursorcolumn
" Display extra whitespace
" set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces
" Move window
nmap <Space> <C-w>w
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l
" Numbers
set relativenumber
set number
set iskeyword+=-
set numberwidth=5
" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
set hls is
set noic
set invic
" Autocomplete with dictionary words when spell check is on
set complete+=kspell
"Save with root permission
command! W w !sudo tee > /dev/null %
" Select all
nmap <C-a> gg<S-v>G
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
nnoremap <S-C-p>

" Always use vertical diffs
set diffopt+=vertical
set clipboard=unnamedplus
" Copy to clipboard
set clipboard=unnamed

set lazyredraw
"set termguicolors

set wrap
set linebreak
set nolist
augroup vimrcEx
  autocmd!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
augroup END
" Go file config
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

"au BufRead,BufNewFile .eslintrc.json setlocal filetype=json
"au BufRead,BufNewFile .babelrc setlocal filetype=json
"au BufRead,BufNewFile .prettierrc setlocal filetype=json

"au BufRead,BufNewFile .babelrc.js setlocal filetype=javascript
"au BufRead,BufNewFile .sequelizerc setlocal filetype=javascript
"au BufRead,BufNewFile *.hbs setlocal filetype=html

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Use tab with text block
"vmap <Tab> >gv
"vmap <S-Tab> <gv
noremap <F3> :Autoformat<CR>
"Comment"
noremap <C-m> :Commentary<cr>
" nnoremap <C-]> :BraceyReload<cr>
"Format
nnoremap <C-t> :Format<cr>
"Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

"nnoremap <Leader>\ :vsplit<CR>
"nnoremap <Leader>/ :split<CR>

" Remove highlight
map <C-h> :nohl<CR>
"Emmet
nnoremap E :Emmet
" NERD tree configuration
nnoremap F :NERDTreeFind<CR>

let NERDTreeShowHidden=1

" fzf

"change normal in terminal
tnoremap <Esc><Esc> <C-\><C-n>
" bind \ (backward slash) to grep shortcut
"nnoremap K :Ag <C-R><C-W><CR>
nnoremap <C-k> /<C-R><C-W><CR>
"nnoremap \ :Ag<SPACE>

" GoTo code navigation.et g:lightline = {
" \ 'colorscheme': 'light',
" \ 'active': {
" \   'left': [ [ 'mode', 'paste' ],
" \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ],
" \   'right': [ [ 'lineinfo', 'percent' ],
" \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
" \ },
" \ 'separator': { 'left': '', 'right': '' },
" \ 'subseparator': { 'left': '', 'right': '' },
" \ 'component_function': {
" \   'gitbranch': 'fugitive#head',
" \   'cocstatus': 'coc#status'
" \ },
" \ }


" Auto close tag
" let g:closetag_filenames = '*.html,*.js,*.jsx,*.vue,*.css'
let g:closetag_emptyTags_caseSensitive = 1
let g:jsx_ext_required = 0
"coc-css
autocmd FileType scss setl iskeyword+=@-@

augroup css_dash_autocompletion
  autocmd FileType scss,css autocmd! css_dash_autocompletion InsertEnter <buffer> set isk+=-
  autocmd FileType scss,css autocmd css_dash_autocompletion InsertLeave <buffer> set isk-=-
augroup EN
