return {
	"NeogitOrg/neogit",
	-- tag = "v0.0.1",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed, not both.
		"nvim-telescope/telescope.nvim", -- optional
		"ibhagwan/fzf-lua", -- optional
	},
	keys = {
		{
			"<leader>g",
			function()
				require("neogit").open({ kind = "replace" })
			end,
			desc = "Open Neogit UI",
		},
	},
	config = true,
}
