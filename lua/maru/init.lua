require("maru.keys")
require("maru.packer")

-- make sure we can detect if we're running in wsl or plain linux
local isWsl = false
local io = require("io")
local file = io.open("/etc/wsl.conf")
if file ~= nil then
	io.close(file)
	isWsl = true
end

local tab_size = 4

vim.opt.guicursor = ""

vim.opt.guicursor = ""
vim.opt.ignorecase = true

-- no idea why this doesn't work
-- vim.opt.autoindent = true
vim.cmd([[set autoindent]])

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

if isWsl then
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "/mnt/c/ProgramData/chocolatey/lib/win32yank/tools/win32yank.exe -i --crlf",
			["*"] = "/mnt/c/ProgramData/chocolatey/lib/win32yank/tools/win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "/mnt/c/ProgramData/chocolatey/lib/win32yank/tools/win32yank.exe -o --lf",
			["*"] = "/mnt/c/ProgramData/chocolatey/lib/win32yank/tools/win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}
else
	vim.opt.clipboard = { "unnamed", "unnamedplus" }
end

vim.cmd([[autocmd FileType php setlocal commentstring=//\ %s]])
vim.cmd([[autocmd FileType json set equalprg=jq]])

-- vim.api.nvim_create_user_command('Symbols', 'Telescope symbols', {})
