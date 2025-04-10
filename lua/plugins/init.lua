return {
	{ "folke/neodev.nvim", opts = {} },
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

	{
		"nvim-treesitter/nvim-treesitter",
		name = "treesitter",
		build = ":TSUpdate",
	},

	"nvim-treesitter/playground",
	"IndianBoy42/tree-sitter-just",

	-- Unfortunately, treesitter doen't razor or blade syntax yet
	"jlcrochet/vim-razor",
	"jwalton512/vim-blade",

	-- Move around
	{ "echasnovski/mini.nvim", version = false },
	"jiangmiao/auto-pairs",
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

	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		dependencies = {
			-- LSP Support
			"neovim/nvim-lspconfig",
			{ "williamboman/mason.nvim", build = ":MasonUpdate" },
			"williamboman/mason-lspconfig.nvim",

			"Hoffs/omnisharp-extended-lsp.nvim",

			-- Autocompletion
			"hrsh7th/nvim-cmp", -- Required
			"hrsh7th/cmp-nvim-lsp", -- Required
			"hrsh7th/cmp-buffer", -- Optional
			"hrsh7th/cmp-path", -- Optional
			"saadparwaiz1/cmp_luasnip", -- Optional
			"Issafalcon/lsp-overloads.nvim",
			"ray-x/lsp_signature.nvim",

			"hrsh7th/cmp-nvim-lua", -- Optional

			"L3MON4D3/LuaSnip",
		},
	},
}
