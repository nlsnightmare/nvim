require("nvim-tree").setup({
	-- sync_root_with_cwd = true,
	-- respect_buf_cwd = true,
	view = {
		width = 40,
		relativenumber = true,
	},
})

vim.keymap.set("n", "<leader>F", ":NvimTreeFindFile<CR>zz")
