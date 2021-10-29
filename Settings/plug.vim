
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
call plug#end()
let g:one_allow_italics = 1 " I love italic for comments
syntax on
colorscheme onedark
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
augroup END

noremap <F3> :Autoformat<CR>
"Comment"
noremap <C-m> :Commentary<cr>
"Format
nnoremap <C-t> :Format<cr>
nnoremap E :Emmet
" NERD tree configuration
nnoremap F :NERDTreeFind<CR>

let NERDTreeShowHidden=1

" fzf

"change normal in terminal
tnoremap <Esc><Esc> <C-\><C-n>
" bind \ (backward slash) to grep shortcut
