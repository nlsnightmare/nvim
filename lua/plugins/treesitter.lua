return {
	{
		"nvim-treesitter/nvim-treesitter",
		name = "treesitter",
		build = ":TSUpdate",
		branch = "main",
		lazy = false,
	},

	"IndianBoy42/tree-sitter-just",
	-- Unfortunately, treesitter doen't razor or blade syntax yet
	"jlcrochet/vim-razor",
	"jwalton512/vim-blade",
}
