local telescope = require("telescope.builtin")

vim.opt.autoindent = true
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert", "fuzzy" }
vim.opt.shortmess:append("c")

-- vim.lsp.config("typescript-language-server", {
-- 	filetypes = { "javascript", "typescript", "htmlangular" },
-- 	root_markers = { "package.json" },
-- })

vim.lsp.config("angularls", {
	filetypes = { "htmlangular", "html" },
	root_markers = { "angular.json" },
})

vim.lsp.config("dartls", {})

vim.lsp.config["biome"] = {
	filetypes = { "json" },
}

vim.lsp.enable({
	"dartls",
	"lua_ls",
	"intelephense",
	"jsonls",
	"emmet_ls",
	"omnisharp",
	"angularls",
	"tsgo",
	"biome",
})
vim.lsp.enable("text", false)

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		-- 		if client:supports_method("textDocument/completion") then
		-- 			vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
		-- 		end

		local opts = { buffer = event.buf }

		-- 		-- huh? looks like lsp disables autoindent
		-- 		-- Open definition in vsplit

		-- 		-- stylua: ignore start
		vim.keymap.set("n", "gD", ":vsp<cr><C-]>", opts)
		-- vim.keymap.set("n", "K",           vim.lsp.buf.hover,                   opts)
		vim.keymap.set("n", "gr", telescope.lsp_references)
		vim.keymap.set("n", "gd", telescope.lsp_definitions)
		vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
		vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
		vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
		-- 		-- stylua: ignore end
	end,
})

vim.api.nvim_create_user_command("EditSnippets", function()
	require("luasnip.loaders").edit_snippet_files()
end, { desc = "Edit available snippets" })
