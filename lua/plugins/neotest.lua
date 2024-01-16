return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"olimorris/neotest-phpunit",
	},

	keys = {
		{ "<leader>T", "<cmd>Neotest run<cr>", desc = "Neotest" },
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-phpunit"),
			},
		})
	end,
}
