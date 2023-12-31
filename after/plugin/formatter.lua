-- https://github.com/mhartington/formatter.nvim

local settings = {
	lua = { require("formatter.filetypes.lua").stylua },
	typescript = { require("formatter.filetypes.typescript").prettier },
	json = { require("formatter.filetypes.json").fixjson },
	scss = { require("formatter.filetypes.css").prettier },
	sh = { require("formatter.filetypes.sh").shfmt },
	markdown = { require("formatter.filetypes.markdown").prettier },
	html = { require("formatter.filetypes.html").prettier },
	xml = { require("formatter.filetypes.html").htmlbeautify },
	sql = { require("formatter.filetypes.sql").pgformat },
	cs = { require("formatter.filetypes.cs").csharpier },

	["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
}

require("formatter").setup({
	logging = false,
	log_level = vim.log.levels.WARN,
	filetype = settings,
})

vim.keymap.set("n", "<leader>f", function()
	if settings[vim.bo.filetype] ~= nil then
		vim.cmd([[Format]])
	else
		vim.lsp.buf.format()
	end
end)

vim.cmd([[autocmd BufWritePre * :Format]])
