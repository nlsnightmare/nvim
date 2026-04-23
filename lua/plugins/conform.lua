return {
	"stevearc/conform.nvim",
	lazy = false,
	event = { "BufWritePre" },
	cmd = { "Conform" },
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
			typescript = { "prettierd", "prettier" },
			json = { "prettierd", "fixjson" },
			jsonc = { "prettierd", "fixjson" },
			scss = { "prettierd", "prettier" },
			sh = { "shfmt" },
			markdown = { "prettierd", "prettier" },
			html = { "prettierd", "prettier" },
			htmlangular = { "prettierd", "prettier" },
			xml = { "prettierd", "xmlformatter" },
			sql = { "pgformat" },
			cs = { "csharpier" },
			javascript = { "prettierd", "prettier" },
			blade = { "blade-formatter", "prettierd" },
		},

		format_after_save = function(bufnr)
			if vim.b.disable_autoformat then
				return
			end

			return { timeout_ms = 100, lsp_fallback = true }
		end,

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
