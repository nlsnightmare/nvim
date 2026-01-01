return {
	{
		"folke/neodev.nvim",
		opts = {},
		dependencies = {
			{ "williamboman/mason-lspconfig.nvim", dependencies = { "mason-org/mason.nvim" } },
		},
	},
	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				input = {
					enabled = true,
					default_prompt = "> ",
				},
				select = { enabled = true },
			})
		end,
	},

	{ "catppuccin/nvim", name = "catppuccin" },
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "Shatur/neovim-ayu", name = "ayu" },
	{ "folke/tokyonight.nvim", name = "tokyonight" },
	{ "rebelot/kanagawa.nvim", name = "kanagawa" },
	{ "Everblush/nvim", name = "everblush" },
	{ "embark-theme/vim", name = "embark" },
	{ "nyoom-engineering/oxocarbon.nvim" },
	{ "challenger-deep-theme/vim", name = "challenger-deep" },
	"EdenEast/nightfox.nvim",
	{
		"utilyre/barbecue.nvim",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		config = function()
			require("barbecue").setup()
		end,
	},

	-- Move around
	{ "echasnovski/mini.nvim", version = false },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},

	"tpope/vim-commentary",
	"junegunn/vim-easy-align",
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	},
	-- { 'utilyre/sentiment.nvim', config = function()
	-- 	require("sentiment").setup {}
	-- end }
	{ "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{ "jghauser/mkdir.nvim" },

	-- LSP Support
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
}
