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

	{ "catppuccin/nvim",                 name = "catppuccin" },
	{ "rose-pine/neovim",                name = "rose-pine" },
	{ "Shatur/neovim-ayu",               name = "ayu" },
	{ "folke/tokyonight.nvim",           name = "tokyonight" },
	{ "rebelot/kanagawa.nvim",           name = "kanagawa" },
	{ "Everblush/nvim",                  name = "everblush" },
	{ "embark-theme/vim",                name = "embark" },
	{ "nyoom-engineering/oxocarbon.nvim" },
	{ "challenger-deep-theme/vim",       name = "challenger-deep" },
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
	{ "echasnovski/mini.nvim",    version = false },
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
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

	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		-- use a release tag to download pre-built binaries
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "enter",
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
			},
			snippets = { preset = "luasnip" },

			sources = {
				default = { "lsp", "snippets" },
				providers = {
					snippets = { min_keyword_length = 0 },
				},
			},

			signature = { enabled = true },
			appearance = { nerd_font_variant = "mono" },

			-- (Default) Only show the documentation popup when manually triggered
			completion = {
				menu = {
					draw = {
						columns = {
							{ "kind_icon", "label", "label_description", gap = 2 },
						},
						padding = { 1, 1 }, -- padding only on right side
					},
				},

				trigger = {
					show_on_keyword = true,
					show_on_trigger_character = true,
					show_on_insert_on_trigger_character = true,
					show_on_accept_on_trigger_character = true,
				},

				ghost_text = {
					enabled = false,
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 0,
				},
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },

		dependencies = {
			"ray-x/lsp_signature.nvim",
			"Hoffs/omnisharp-extended-lsp.nvim",
			"Issafalcon/lsp-overloads.nvim",
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				build = "make install_jsregexp",
				config = function()
					require("luasnip.loaders.from_snipmate").lazy_load()
					require("luasnip").setup({
						enable_autosnippets = true,
					})
				end,
			},
		},
	},

	"neovim/nvim-lspconfig",

	-- Autocompletion
	-- "hrsh7th/nvim-cmp", -- Required
	-- "hrsh7th/cmp-nvim-lsp", -- Required
	-- "hrsh7th/cmp-buffer", -- Optional
	-- "hrsh7th/cmp-path", -- Optional
	-- "saadparwaiz1/cmp_luasnip", -- Optional
}
