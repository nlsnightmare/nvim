-- https://github.com/mhartington/formatter.nvim
local settings = {
	lua = { require("formatter.filetypes.lua").stylua },
	typescript = { require("formatter.filetypes.typescript").prettier },
	json = { require("formatter.filetypes.json").fixjson },
	html = { require("formatter.filetypes.html").htmlbeautify },
	xml = { require("formatter.filetypes.html").htmlbeautify },

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
}

require("formatter").setup({
	logging = false,
	log_level = vim.log.levels.WARN,
	filetype = settings,
})

vim.cmd([[autocmd BufWritePre * :Format]])
vim.keymap.set("n", "<leader>f", function()
	if settings[vim.g.filetype] ~= nil then
		vim.cmd([[Format]])
	else
		vim.lsp.buf.format()
	end
	print("formatting")
	vim.cmd([[Format]])
end)
