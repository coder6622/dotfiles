" Find files using Telescope command-line sugar.
nnoremap <silent> 'f <cmd>Telescope find_files<cr>
nnoremap <silent> 'r <cmd>Telescope live_grep<cr>
nnoremap <silent> \\ <cmd>Telescope buffers<cr>
nnoremap <silent> '; <cmd>Telescope help_tags<cr>
if !exists('g:loaded_telescope') | finish | endif
lua << EOF
function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup{
defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}
EOF


