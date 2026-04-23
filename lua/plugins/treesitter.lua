return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		branch = "main",
		lazy = false,
		init = function()
			vim.api.nvim_create_autocmd('FileType', {
				callback = function()
					-- Enable treesitter highlighting and disable regex syntax
					pcall(vim.treesitter.start)

					-- Enable treesitter-based indentation
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			})
		end
	},

	{ "IndianBoy42/tree-sitter-just" },
	-- Unfortunately, treesitter doen't razor or blade syntax yet
	{ "jlcrochet/vim-razor" },
	{ "jwalton512/vim-blade" },
}
