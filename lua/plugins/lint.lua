return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")

		lint.linters_by_ft["php"] = { "phpstan" }
		-- Use the "*" filetype to run linters on all filetypes.
		-- ["*"] = { "global linter" },
		-- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
