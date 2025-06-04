return {
	"folke/zen-mode.nvim",
	name = "zen-mode",
	keys = {
		{ "<leader>z", "<cmd>:ZenMode<CR>", desc = "Zen Mode" },
	},
	opts = {
		window = {
			width = 140,
		},
		plugins = {
			options = {
				showcmd = true,
			},
		},
		-- Make :q exit vim when on zen mode
		-- see: https://github.com/folke/zen-mode.nvim/issues/35
		on_open = function(_)
			vim.cmd("cabbrev <buffer> q let b:quitting = 1 <bar> q")
			vim.cmd("cabbrev <buffer> wq let b:quitting = 1 <bar> wq")
		end,
		on_close = function()
			if vim.b.quitting == 1 then
				vim.b.quitting = 0
				vim.cmd("q")
			end
		end,
	},
}
