local lint = require("lint")

local function dd(arg)
	print(vim.inspect(arg))
end

lint.linters_by_ft = {
	php = { "phpstan" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		lint.try_lint()
	end,
})
