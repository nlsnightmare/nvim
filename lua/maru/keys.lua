vim.g.mapleader = " "

vim.keymap.set("n", "Q", "<nop>")

-- move lines around in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- vim.keymap.set('i', '(;', '(<CR>);<C-c>O')
-- vim.keymap.set('i', '(,', '(<CR>),<C-c>O')
-- vim.keymap.set('i', '{;', '{<CR>};<C-c>O')
-- vim.keymap.set('i', '{,', '{<CR>},<C-c>O')
-- vim.keymap.set('i', '[;', '[<CR>];<C-c>O')
-- vim.keymap.set('i', '[,', '[<CR>],<C-c>O')


-- keep cursor position when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor centered when finding next search result
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<C-s>", ":w<CR>")

vim.keymap.set("x", "<leader>d", '"_dP')

-- working with splits
vim.keymap.set("n", "<leader>|", ":vs<cr>")
vim.keymap.set("n", "H", "<C-w>h")
vim.keymap.set("n", "L", "<C-w>l")

vim.g.EasyMotion_smartcase = 1
vim.keymap.set("n", "<leader>s", "<Plug>(easymotion-bd-f)")
vim.keymap.set("n", "<leader>S", "<Plug>(easymotion-sn)")

vim.keymap.set("v", "ga", "<PLUG>(EasyAlign)")
vim.keymap.set("x", "ga", "<PLUG>(EasyAlign)")

vim.keymap.set("n", "<leader>q", ":bd<CR>")
vim.keymap.set("n", "<leader>Q", ":%bd<CR>")

vim.keymap.set("n", "<leader>pi", function()
	local home = os.getenv("HOME") .. "/.config/nvim/lua/maru/packer.lua"
	vim.cmd("source " .. home)
	vim.cmd("PackerSync")
end)

vim.keymap.set("n", "<leader><leader>", ":so<cr>")
