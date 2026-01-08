return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"olimorris/neotest-phpunit",
	},
	cmd = "Neotest",
	keys = {
		{ "<leader>R", "<cmd>Neotest run<cr>", desc = "Run test under cursor" },
		{ "<leader>tr", "<cmd>Neotest run<cr>", desc = "Run test under cursor" },
		{ "<leader>ts", "<cmd>Neotest summary<cr>", desc = "Neotest Summary" },
		{ "<leader>to", "<cmd>Neotest output-panel<cr>", desc = "Neotest Output Panel" },
		{ "<leader>tn", "<cmd>Neotest jump next<cr>", desc = "Neotest Jump (next test)" },
		{ "<leader>tp", "<cmd>Neotest jump next<cr>", desc = "Neotest Jump (prev test)" },
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-phpunit")({
					env = {
						XDEBUG_CONFIG = "idekey=neotest",
					},
				}),
			},
		})
	end,
}
