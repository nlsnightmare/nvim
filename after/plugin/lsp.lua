local telescope = require("telescope.builtin")

vim.opt.autoindent = true
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert", "fuzzy" }
vim.opt.shortmess:append("c")

vim.lsp.config("angularls", {
	filetypes = { "htmlangular", "html" },
	root_markers = { "angular.json" },
})

vim.lsp.config["dartls"] = {
	cmd = {
		"fvm",
		"dart",
		"language-server",
		"--protocol=lsp",
	},
}

vim.lsp.config("biome", {})
vim.lsp.enable("biome")

vim.lsp.config("emmet_ls", { filetypes = { "htmlangular", "html", "blade", "scss", "css" } })

-- vim.lsp.config("ts_ls", { filetypes = { "typescript" } })
vim.lsp.config("angularls", {
	filetypes = { "html", "htmlangular" },
	cmd = function(dispatchers, config)
		local root_dir = (config and config.root_dir) or vim.fn.getcwd()
		-- Always resolve @angular/language-service from Mason's own bundle, matched
		-- to the ngserver shell version. Probing the project's local node_modules
		-- here (the lspconfig default) can pick up an older language-service that
		-- lacks APIs the shell expects, e.g. `ensureProjectAnalyzed`, which throws
		-- during project load and silently kills all template completions.
		local mason_ng = vim.fn.stdpath("data")
			.. "/mason/packages/angular-language-server/node_modules/@angular/language-server/node_modules"
		local cmd = {
			"ngserver",
			"--stdio",
			"--tsProbeLocations",
			root_dir .. "/node_modules",
			"--ngProbeLocations",
			mason_ng,
		}
		return vim.lsp.rpc.start(cmd, dispatchers)
	end,
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			-- this enables completion, but it's so, so, so slow it's not even worth it in most cases.
			-- workspace = { library = vim.api.nvim_get_runtime_file("", true), },
			telemetry = { enable = false },
			diagnostics = { globals = { "vim" } },
		},
	},
})

vim.lsp.enable({
	"clangd",
	"gleam",
	"runst_analyzer",
	"dartls",
	"lua_ls",
	"intelephense",
	"emmet_ls",
	"omnisharp",
	"angularls",
	"tsc",
	"jsonls",
})

vim.lsp.enable("text", false)

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		-- 		if client:supports_method("textDocument/completion") then
		-- 			vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
		-- 		end

		-- Common options for everything
		local opts = { buffer = event.buf }

		-- stylua: ignore start
		vim.keymap.set("n", "gD", ":vsp<cr><C-]>", opts)
		vim.keymap.set("n", "gr", telescope.lsp_references)
		vim.keymap.set("n", "gd", telescope.lsp_definitions)
		vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
		vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
		vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
		-- stylua: ignore end
	end,
})

vim.api.nvim_create_user_command("EditSnippets", function()
	require("luasnip.loaders").edit_snippet_files()
end, { desc = "Edit available snippets" })
