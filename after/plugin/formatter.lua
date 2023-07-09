-- https://github.com/mhartington/formatter.nvim
local util = require("formatter.util")

require("formatter").setup({
	logging = false,
	log_level = vim.log.levels.WARN,
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
			function()
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},

		json = {
			require("formatter.filetypes.json").fixjson,
			function()
				return {
					exe = "fixjson",
					args = { "--stdin-filename", util.get_current_buffer_file_name() },
					stdin = true,
					try_node_modules = true,
				}
			end,
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
