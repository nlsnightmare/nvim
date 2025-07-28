return {
	"lewis6991/gitsigns.nvim",
	opts = {},
	keys = {
		{
			"[c",
			function()
				require("gitsigns").nav_hunk("next")
			end,
			mode = "n",
			desc = "Next Change",
		},
		{
			"]c",
			function()
				require("gitsigns").nav_hunk("prev")
			end,
			mode = "n",
			desc = "Previous Change",
		},
	},
}
