return {
	"stevearc/aerial.nvim",
	keys = {
		{ "<leader>n", "<cmd>AerialNavOpen<cr>" },
	},
	opts = {
		close_on_select = true,
		keymaps = {
			["<ESC>"] = "actions.close",
			["q"] = "actions.close",
		},
	},
}
