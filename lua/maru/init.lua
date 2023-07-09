require("maru.keys")
require("maru.packer")

local tab_size = 4

vim.opt.guicursor = ""
vim.opt.ignorecase = true

-- no idea why this doesn't work
-- vim.opt.autoindent = true
vim.cmd("set autoindent")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = tab_size
vim.opt.softtabstop = tab_size
vim.opt.shiftwidth = tab_size
vim.opt.expandtab = false
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.splitright = true

vim.opt.swapfile = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.cmd [[autocmd FileType php setlocal commentstring=//\ %s]]
vim.cmd [[autocmd FileType json set equalprg=jq]]

vim.api.nvim_create_user_command('Symbols', 'Telescope symbols', {})
