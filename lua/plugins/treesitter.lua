return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		branch = "master",
		lazy = false,
		init = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},

	{ "IndianBoy42/tree-sitter-just" },
	-- Unfortunately, treesitter doen't razor or blade syntax yet
	{ "jlcrochet/vim-razor" },
	{ "jwalton512/vim-blade" },
}
