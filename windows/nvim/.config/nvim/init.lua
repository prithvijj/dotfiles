local vim = vim
local Plug = vim.fn["plug#"]
 
-- Set relative line numbers
vim.o.number = true
vim.opt.relativenumber = true
 
-- enable syntax highlighting
vim.cmd('syntax on')
 
vim.opt.showmatch = true
 
vim.opt.mouse = 'a'
 
vim.opt.hlsearch = true
 
-- Show which line your cursor is on
vim.o.cursorline = true
 
-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10
 
vim.opt.ignorecase = true
 
vim.opt.smartcase = true

vim.o.smartindent = true
vim.o.autoindent = true

-- Always show the sign column
vim.o.signcolumn = "yes"  
-- Enable persistent undo
vim.opt.undofile = true

-- Set undo directory
local undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undodir = undodir

-- Create the undo directory if it doesn't exist
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end

-- Use the system clipboard for all yank, delete, change, and put operations
vim.g.clipboard = {
  copy = {
    ["+"] = "clip.exe",
    ["*"] = "clip.exe",
  },
  paste = {
    ["+"] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    ["*"] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  },
  cache_enabled = 0,
}

vim.opt.clipboard = 'unnamedplus'
vim.opt.colorcolumn = '80'
 
vim.cmd('hi ColorColumn ctermbg=lightgrey guibg=lightgrey')
 
vim.opt.autoread = true
vim.opt.spell = true
vim.opt.spelllang = {'en_us'}
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Set leader key to space
vim.g.mapleader = ' '

vim.call("plug#begin", "~/.vim/plugged")

 Plug('junegunn/fzf', {["do"] = './install -all'})
 Plug('junegunn/fzf.vim')
 Plug('preservim/nerdtree')
 Plug('nvim-lua/plenary.nvim')
 -- Jun 2, 2025 - Trying out fzf first
 Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.8'})
 -- Mason for LSP Management
 Plug('williamboman/mason.nvim', { ["do"] = ':MasonUpdate' })
 Plug('williamboman/mason-lspconfig.nvim')
 -- LSP & Autocomplete
 Plug('neovim/nvim-lspconfig')
 Plug('hrsh7th/cmp-nvim-lsp')
 Plug('hrsh7th/cmp-buffer')
 Plug('hrsh7th/cmp-path')
 Plug('hrsh7th/cmp-cmdline')
 Plug('hrsh7th/nvim-cmp')
 
 -- Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
 -- require("lazy").setup({{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}})
 Plug('nvim-treesitter/nvim-treesitter')
 Plug('ray-x/go.nvim')
 
 -- Plug('catppuccin/nvim'), { ["as"] = "catppuccin" })
 Plug('catppuccin/nvim', { ["as"] = 'catppuccin' })
 -- Working with parenthesis
 Plug('windwp/nvim-autopairs')
vim.call('plug#end')

vim.cmd('colorscheme catppuccin')

-- Options for silent and non-recursive mappings
 local opts = { noremap = true, silent = true }
 
 -- Example mappings for fzf.vim
 vim.keymap.set('n', '<leader>p', ':Files<CR>', opts)
 vim.keymap.set('n', '<leader>b', ':Buffers<CR>', opts)
 vim.keymap.set('n', '<leader>fl', ':Lines<CR>', opts)
 
 local builtin = require('telescope.builtin')
 -- vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
 vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
 -- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
 -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
 
 -- Move between panes using leader key and arrow keys
 vim.keymap.set('n', '<leader>h', '<C-w>h', opts) -- Move to the left pane
 vim.keymap.set('n', '<leader>j', '<C-w>j', opts) -- Move to the bottom pane
 vim.keymap.set('n', '<leader>k', '<C-w>k', opts) -- Move to the top pane
 vim.keymap.set('n', '<leader>l', '<C-w>l', opts) -- Move to the right pane
 
 -- Add Commenting stuff
 -- Ref: https://www.reddit.com/r/neovim/comments/1d278fz/comment/l5zimt1/
 -- Normal mode: Toggle line comment
 vim.keymap.set('n', '<leader>/', ':normal gcc<CR>', {desc = '[/] Toggle Comment line'})
 
 -- Visual mode: Toggle block comment
 vim.keymap.set('v', '<leader>/', '<Esc>:normal gvgc<CR>', { desc = '[/] Toggle comment block' })
 
 -- Add LSP stuff here
 vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Show hover' })
 vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
 vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation'})
 vim.keymap.set('n', 'grr', vim.lsp.buf.references, bufopts, { desc = 'Show references' })
 vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

 require'nvim-treesitter.configs'.setup {
   -- A list of parser names, or "all"
   ensure_installed = { "go","markdown","typescript", "lua", "python", "javascript" }, -- Add languages you want to support
 
   -- Install languages synchronously (only applied to `ensure_installed`)
   sync_install = false,
 
   -- Automatically install missing parsers when entering buffer
   auto_install = true,
 
   highlight = {
     enable = true,              -- false will disable the whole extension
     additional_vim_regex_highlighting = false,
   },
 }
 require'mason'.setup()
 require'mason-lspconfig'.setup {
     enable = true,
     ensure_installed = { "gopls", "lua_ls", "rust_analyzer" },
 } 

 -- nvim-cmp setup
 local cmp = require'cmp'
 
 cmp.setup({
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
        ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' }
    })
 })
 
 -- Setup lspconfig.
 local capabilities = require('cmp_nvim_lsp').default_capabilities()
 
-- Setup gopls
require('lspconfig').gopls.setup({
  capabilities = capabilities,
  settings = {
	  gopls = {
		  gofumpt = true,
		  completeUnimported = true,
		  analyses = {
			  unusedparams = true,
			  unreachable = true,
			  shadow = true,
		  },
		  staticcheck = true,
                  ["ui.completion.usePlaceholders"] = true,
                  ["ui.importShortcut"] = "Both",
	  },
  },
})

-- require('lspconfig').gopls.setup({
--   capabilities = capabilities,
--   settings = {
-- 	  gopls = {
-- 		  formatting = "goimports",
-- 	  },
--   },
-- })
--
 -- Function to format code using LSP before saving
 -- local function lsp_format_on_save()
 --     vim.lsp.buf.format({ async = false })
 -- end
 --

 -- Autocommand to run LSP formatting on save for Go files
 -- vim.api.nvim_create_autocmd("BufWritePre", {
 --     pattern = "*.go",
 --     callback = lsp_format_on_save,
 -- })
 --
local function go_organize_imports_and_format()
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }

  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
  for _, res in pairs(result or {}) do
    for _, action in pairs(res.result or {}) do
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit, "utf-16")
      end
      if type(action.command) == "table" then
        vim.lsp.buf.execute_command(action.command)
      end
    end
  end

  vim.lsp.buf.format({ async = false })
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = go_organize_imports_and_format,
})


 require('nvim-autopairs').setup {
  check_ts = true,
  fast_wrap = {},
  disable_filetype = { "TelescopePrompt", "vim"},
 }
