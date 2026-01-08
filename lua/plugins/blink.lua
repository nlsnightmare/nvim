return {
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
			["<C-j>"] = { "snippet_forward" },
		},
		snippets = { preset = "luasnip" },

		sources = {
			default = { "lsp", "snippets", "path" },
			providers = {
				snippets = { min_keyword_length = 0 },
			},
		},

		signature = { enabled = true },
		appearance = { nerd_font_variant = "mono" },

		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			menu = {
				border = "single",
				draw = {
					columns = { { "label", "label_description", gap = 1 }, { "kind_icon" } },
					-- components = {},
					padding = { 1, 1 }, -- padding only on right side
				},
			},

			-- trigger = {
			-- 	show_on_keyword = true,
			-- 	show_on_trigger_character = true,
			-- 	show_on_insert_on_trigger_character = true,
			-- 	show_on_accept_on_trigger_character = true,
			-- },

			ghost_text = {
				enabled = false,
			},
			signature = {
				window = { border = "single" },
			},
			documentation = {
				window = { border = "single" },
				auto_show = true,
				auto_show_delay_ms = 20,
			},
		},

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "rust" },
	},
	opts_extend = { "sources.default" },

	dependencies = {
		"ray-x/lsp_signature.nvim",
		"neovim/nvim-lspconfig",
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
}
