return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		branch = "main",
		lazy = false,
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					-- Enable treesitter highlighting and disable regex syntax
					pcall(vim.treesitter.start)

					-- Enable treesitter-based indentation, but only when the language
					-- actually ships an indents query. Without one, indentexpr always
					-- returns 0 and clobbers the built-in indent file (e.g. c_sharp).
					local lang = vim.treesitter.language.get_lang(args.match)
					if lang and vim.treesitter.query.get(lang, "indents") then
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},

	{ "IndianBoy42/tree-sitter-just" },
	-- Unfortunately, treesitter doen't razor or blade syntax yet
	{ "jlcrochet/vim-razor" },
	{ "jwalton512/vim-blade" },
}
