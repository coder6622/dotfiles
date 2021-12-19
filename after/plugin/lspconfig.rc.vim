if !exists('g:lspconfig')
  finish
endif

lua << EOF
--vim.lsp.set_log_level("debug")
EOF

lua << EOF
local nvim_lsp = require('lspconfig')
local protocol = require'vim.lsp.protocol'
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
-- Enable completion triggered by <c-x><c-o>
buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
local opts = { noremap=true, silent=true} 
-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

-- formatting
if client.name == 'tsserver' then
  client.resolved_capabilities.document_formatting =true 
end

if client.resolved_capabilities.document_formatting then
  vim.api.nvim_command [[augroup Format]]
  vim.api.nvim_command [[autocmd! * <buffer>]]
  vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
  vim.api.nvim_command [[augroup END]]
end


--protocol.SymbolKind = { }
protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
  }
end
-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').update_capabilities(
vim.lsp.protocol.make_client_capabilities()
)
capabilities.textDocument.completion.completionItem.snippetSupport = true
local servers = { 'pyright', 'tsserver', 'cssls', 'cssmodules_ls', 'emmet_ls', 'eslint', 'html', 'jsonls', 'flow', 'sqlls', 'tailwindcss',   }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
	on_attach = on_attach,
	capabilities = capabilities,
	}
end

nvim_lsp.emmet_ls.setup{
filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'html', 'css', 'scss'}


}

nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'markdown', 'pandoc' },
  init_options = {
	linters = {
	  eslint = {
		command = 'eslint_d',
		rootPatterns = { '.git' },
		debounce = 100,
		args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
		sourceName = 'eslint_d',
		parseJson = {
		  errorsRoot = '[0].messages',
		  line = 'line',
		  column = 'column',
		endLine = 'endLine',
	  endColumn = 'endColumn',
	  message = '[eslint] ${message} [${ruleId}]',
	  security = 'severity'
	  },
	securities = {
	  [2] = 'error',
	  [1] = 'warning'
	  }
	},
  },
filetypes = {
  javascript = 'eslint',
  javascriptreact = 'eslint',
  typescript = 'eslint',
  typescriptreact = 'eslint',
  },
formatters = {
  eslint_d = {
	command = 'eslint_d',
	rootPatterns = { '.git' },
	args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
	rootPatterns = { '.git' },
	},
  prettier = {
	command = 'prettier_d_slim',
	rootPatterns = { '.git' },
	-- requiredFiles: { 'prettier.config.js' },
	args = { '--stdin', '--stdin-filepath', '%filename' }
	}
  },
formatFiletypes = {
  css = 'prettier',
  javascript = 'prettier',
  javascriptreact = 'prettier',
  json = 'prettier',
  scss = 'prettier',
  less = 'prettier',
  typescript = 'prettier',
  typescriptreact = 'prettier',
  json = 'prettier',
  markdown = 'prettier',
  }
}
}

--icon
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  -- This sets the spacing and the prefix, obviously.
  virtual_text = {
	spacing = 4,
	prefix = ''
	}
  }
)



require("todo-comments").setup {

  {

	  signs = true, -- show icons in the signs column
	  sign_priority = 8, -- sign priority
	  -- keywords recognized as todo comments
	  keywords = {
		fix = {
		  icon = " ", -- icon used for the sign, and in search results
		  color = "error", -- can be a hex color, or a named color (see below)
		  alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
		  -- signs = false, -- configure signs for some keywords individually
		  },
		TODO = { icon = " ", color = "info" },
		HACK = { icon = " ", color = "warning" },
		WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
		PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
		},
	  merge_keywords = true, -- when true, custom keywords will be merged with the defaults
	  -- highlighting of the line containing the todo comment
	  -- * before: highlights before the keyword (typically comment characters)
	  -- * keyword: highlights of the keyword
	  -- * after: highlights after the keyword (todo text)
	  highlight = {
		before = "", -- "fg" or "bg" or empty
		keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
		after = "fg", -- "fg" or "bg" or empty
		pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
		comments_only = true, -- uses treesitter to match keywords in comments only
		max_line_len = 400, -- ignore lines longer than this
		exclude = {}, -- list of file types to exclude highlighting
		},
	  -- list of named colors where we try to extract the guifg from the
	  -- list of hilight groups or use the hex color if hl not found as a fallback
	  colors = {
		error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
		warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
		info = { "DiagnosticInfo", "#2563EB" },
		hint = { "DiagnosticHint", "#10B981" },
		default = { "Identifier", "#7C3AED" },
		},
	  search = {
		command = "rg",
		args = {
		  "--color=never",
		  "--no-heading",
		  "--with-filename",
		  "--line-number",
		  "--column",
		  },
		-- regex that will be used to match keywords.
		-- don't replace the (KEYWORDS) placeholder
		pattern = [[\b(KEYWORDS):]], -- ripgrep regex
		-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
		},
}
}


require('Comment').setup(
{
  ---Add a space b/w comment and the line
  ---@type boolean
  padding = true,

  ---Whether the cursor should stay at its position
  ---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
  ---@type boolean
  sticky = true,

  ---Lines to be ignored while comment/uncomment.
  ---Could be a regex string or a function that returns a regex string.
  ---Example: Use '^$' to ignore empty lines
  ---@type string|fun():string
  ignore = nil,

  ---LHS of toggle mappings in NORMAL + VISUAL mode
  ---@type table
  toggler = {
	---Line-comment toggle keymap
	line = 'gcc',
	---Block-comment toggle keymap
	block = 'gbc',
	},

  ---LHS of operator-pending mappings in NORMAL + VISUAL mode
  ---@type table
  opleader = {
	---Line-comment keymap
	line = 'gc',
	---Block-comment keymap
	block = 'gb',
	},

  ---LHS of extra mappings
  ---@type table
  extra = {
	---Add comment on the line above
	above = 'gcO',
	---Add comment on the line below
	below = 'gco',
	---Add comment at the end of line
	eol = 'gcA',
	},

  ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
  ---@type table
  mappings = {
	---Operator-pending mapping
	---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
	---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
	basic = true,
	---Extra mapping
	---Includes `gco`, `gcO`, `gcA`
	extra = true,
	---Extended mapping
	---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
	extended = false,
	},

  ---Pre-hook, called before commenting the line
  ---@type fun(ctx: Ctx):string
  pre_hook = nil,

  ---Post-hook, called after commenting is done
  ---@type fun(ctx: Ctx)
  post_hook = nil,
}


)


require 'colorizer'.setup ( 
{'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'html', 'scss'},
 {
	RGB      = true;         -- #RGB hex codes
	RRGGBB   = true;         -- #RRGGBB hex codes
	names    = true;         -- "Name" codes like Blue
	RRGGBBAA = true;        -- #RRGGBBAA hex codes
	rgb_fn   = true;        -- CSS rgb() and rgba() functions
	hsl_fn   = true;        -- CSS hsl() and hsla() functions
	css      = true;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
	css_fn   = true;        -- Enable all CSS *functions*: rgb_fn, hsl_fn
	-- Available modes: foreground, background
	mode     = 'background'; -- Set the display mode.
	}
)
EOF

