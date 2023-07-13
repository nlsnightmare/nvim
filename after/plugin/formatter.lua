-- https://github.com/mhartington/formatter.nvim

require("formatter").setup({
	logging = false,
	log_level = vim.log.levels.WARN,
	filetype = {
		lua = { require("formatter.filetypes.lua").stylua },
		typescript = { require("formatter.filetypes.typescript").prettier },

		json = {
			require("formatter.filetypes.json").fixjson,
		},

		cs = {
			function()
				return {
					exe = "dotnet",
					args = {
						"csharpier",
					},
					stdin = true,
				}
			end,
		},

		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

vim.cmd([[autocmd BufWritePre * :Format]])
vim.keymap.set("n", "<leader>f", function()
	print("formatting")
	vim.cmd([[Format]])
end)
