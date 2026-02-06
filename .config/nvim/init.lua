local vim = vim
local Plug = vim.fn["plug#"]

local data_dir = vim.fn.stdpath('data')
if vim.fn.empty(vim.fn.glob(data_dir .. '/site/autoload/plug.vim')) == 1 then
  vim.cmd('silent !curl -fLo ' .. data_dir .. '/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  vim.o.runtimepath = vim.o.runtimepath
  vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

vim.lsp.set_log_level("debug")

vim.opt.termguicolors = true
-- Set relative line numbers
vim.o.number = true
vim.opt.relativenumber = true
 
-- enable syntax highlighting
vim.cmd('syntax enable')
vim.cmd("filetype plugin indent on")
 
vim.opt.showmatch = true
 
vim.opt.mouse = 'a'
 
vim.opt.hlsearch = true
 
-- Show which line your cursor is on
vim.o.cursorline = true
 
-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10
 
vim.opt.ignorecase = true
 
vim.opt.smartcase = true

-- Show how neovim will display certain whitespace characters
vim.opt.list = true

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

-- For KDE, need `xclip` to be installed
vim.opt.clipboard = 'unnamedplus'
vim.opt.colorcolumn = '80'

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
 -- Working with surrounds
 Plug('echasnovski/mini.surround')
vim.call('plug#end')

vim.cmd('colorscheme catppuccin')

 -- Add Commenting stuff
 -- Ref: https://www.reddit.com/r/neovim/comments/1d278fz/comment/l5zimt1/
 -- Normal mode: Toggle line comment
 vim.keymap.set('n', '<leader>/', ':normal gcc<CR>', {desc = '[/] Toggle Comment line'})
 
 -- Visual mode: Toggle block comment
 vim.keymap.set('v', '<leader>/', '<Esc>:normal gvgc<CR>', { desc = '[/] Toggle comment block' })

-- Options for silent and non-recursive mappings
 local opts = { noremap = true, silent = true }
 
 -- Example mappings for fzf.vim
 vim.keymap.set('n', '<leader>p', ':Files<CR>', opts)
 vim.keymap.set('n', '<leader>b', ':Buffers<CR>', opts)
 vim.keymap.set('n', '<leader>fl', ':Lines<CR>', opts)
 -- Add Commenting stuff
 -- Ref: https://www.reddit.com/r/neovim/comments/1d278fz/comment/l5zimt1/
 -- Normal mode: Toggle line comment
 vim.keymap.set('n', '<leader>/', ':normal gcc<CR>', {desc = '[/] Toggle Comment line'})
 
 -- Visual mode: Toggle block comment
 vim.keymap.set('v', '<leader>/', '<Esc>:normal gvgc<CR>', { desc = '[/] Toggle comment block' })

local builtin = require('telescope.builtin')
 vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
-- vim.keymap.set('n', '<leader>fg', grep_in_root, { desc = 'Telescope live grep' })
 vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
 vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
 vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
 
 -- Move between panes using leader key and arrow keys
 vim.keymap.set('n', '<leader>h', '<C-w>h', opts) -- Move to the left pane
 vim.keymap.set('n', '<leader>j', '<C-w>j', opts) -- Move to the bottom pane
 vim.keymap.set('n', '<leader>k', '<C-w>k', opts) -- Move to the top pane
 vim.keymap.set('n', '<leader>l', '<C-w>l', opts) -- Move to the right pane
 
 
 -- Add LSP stuff here
 vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Show hover' })
 vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
 vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation'})
 vim.keymap.set('n', 'grr', vim.lsp.buf.references, bufopts, { desc = 'Show references' })
 vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

-- Adding NERDTree file explorer keymaps
vim.keymap.set('n', '<leader>n', ':NERDTreeToggle<CR>', opts)

-- Keymaps for bufferline navigation
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { silent = true, desc = 'Next Buffer' })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { silent = true, desc = 'Previous Buffer' })


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
