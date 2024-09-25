return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConfirmInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			typescript = { { "prettierd", "prettier" } },
			json = { "fixjson" },
			scss = { "prettier" },
			sh = { "shfmt" },
			markdown = { { "prettierd", "prettier" } },
			html = { { "prettierd", "prettier" } },
			xml = { "htmlbeautify" },
			sql = { "pgformat" },
			cs = { "csharpier" },
			javascript = { { "prettierd", "prettier" } },
			blade = { "blade-formatter" },
		},
		-- Set up format-on-save
		format_on_save = { timeout_ms = 100, lsp_fallback = true },
		-- Customize formatters
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
		},
	},
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
