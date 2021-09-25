let g:floaterm_position = 'topright'
let g:floaterm_width = 0.4
let g:floaterm_height = 0.6
let g:floaterm_tile = "Terminal 1/3"
let g:floaterm_wintype = 'float'
let g:floaterm_rootmarkers = ['.root']

hi Floaterm guibg=white
hi FloattermBorder guifg=white guibg=white
 
 nnoremap <F8> :FloatermNew<CR> --height=0.8 --width=0.6 --wintype=float --name=Terminal 1/2 --position=topright --autoclose=3 ranger --cmd="cd ~"<CR>
 
 nnoremap   <silent>   <F7>    :FloatermNew<CR>
tnoremap   <silent>   <F7>    <C-\><C-n>
nnoremap   <silent>   <F8>    :FloatermPrev<CR>
tnoremap   <silent>   <F8>    <C-\><C-n>:FloatermPrev<CR>
nnoremap   <silent>   <F9>    :FloatermNext<CR>
tnoremap   <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <F12>   :FloatermToggle<CR>
tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>
autocmd TermClose * ++once :q | call nvim_win_close(<window-id>, v:true)
