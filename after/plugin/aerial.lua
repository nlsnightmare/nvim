require("aerial").setup({
	close_on_select = true,
	keymaps = {
		["<ESC>"] = "actions.close",
		["q"] = "actions.close"
	}
})


vim.keymap.set("n", "<leader>n", function()
	vim.cmd[[AerialNavOpen]]
end)
