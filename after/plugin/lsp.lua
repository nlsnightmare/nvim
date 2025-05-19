-- local lsp = require("lsp-zero")
-- local util = require("lspconfig.util")
-- local omnisharp_extended = require("omnisharp_extended")
local telescope = require("telescope.builtin")

vim.opt.autoindent = true
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert", "fuzzy" }
vim.opt.shortmess:append("c")

vim.lsp.config('typescript-language-server', {
	filetypes = { "javascript", "typescript" },
	root_markers = { "package.json" } })
vim.lsp.config('angular-language-server', {
	filetypes = {"ts", "typescript"},
	root_markers = { "angular.json" } })

vim.lsp.enable({
	"dartls",
	"lua_ls",
	"intelephense",
	"html_ls",
	"emmet_ls",
	"omnisharp",
	"angular-language-server",
	"ts_ls"
})
vim.lsp.enable("text", false)


-- vim.lsp.config('*', {
--   capabilities = {
--     textDocument = {
--       semanticTokens = {
--         multilineTokenSupport = true,
--       }
--     }
--   },
--   root_markers = { '.git' },
-- })

-- vim.lsp.config("html_ls", {
-- 	filetypes = { "html", "cshtml", "blade", "htmlangular" },
-- })

-- vim.lsp.config("emmet_ls", {
-- 	filetypes = {
-- 		"css",
-- 		"eruby",
-- 		"html",
-- 		"cshtml",
-- 		"javascriptreact",
-- 		"htmlangular",
-- 		"less",
-- 		"sass",
-- 		"scss",
-- 		"pug",
-- 		"typescriptreact",
-- 		"blade",
-- 	},
-- })

-- -- Fix Undefined global 'vim'
-- vim.lsp.config("lua_ls", {
-- 	settings = {
-- 		Lua = {
-- 			diagnostics = {
-- 				globals = { "vim" },
-- 			},
-- 		},
-- 	},
-- })

-- vim.lsp.config("omnisharp", {
-- 	handlers = {
-- 		["textDocument/definition"] = function(...)
-- 			return require("omnisharp_extended").handler(...)
-- 		end,
-- 	},
-- 	keys = {
-- 		{
-- 			"gd",
-- 			function()
-- 				require("omnisharp_extended").telescope_lsp_definitions()
-- 			end,
-- 			desc = "Goto Definition",
-- 		},
-- 	},
-- 	enable_roslyn_analyzers = true,
-- 	organize_imports_on_format = true,
-- 	enable_import_completion = true,
-- })

-- vim.lsp.config("csharp_ls", {
-- 	filetypes = { "cs", "razor", "cshtml", "csproj" },
-- })

-- -- Prevent the server from moving things around
-- local cmp = require("cmp")
-- local luasnip = require("luasnip")
-- luasnip.config.setup({
-- 	enable_autosnippets = true,
-- 	region_check_events = "CursorHold,InsertLeave",
-- 	-- those are for removing deleted snippets, also a common problem
-- 	delete_check_events = "TextChanged,InsertEnter",
-- })

-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "./snippets" } })

-- local has_words_before = function()
-- 	unpack = unpack or table.unpack
-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

-- -- local cmp_mappings = lsp.defaults.cmp_mappings({
-- -- 	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
-- -- 	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
-- -- 	["<Tab>"] = cmp.mapping(function(fallback)
-- -- 		if cmp.visible() then
-- -- 			-- no idea why complete doesnt work here
-- -- 			-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
-- -- 			cmp.select_next_item(cmp_select)
-- -- 			cmp.complete({ select = true })
-- -- 			-- cmp.select_next_item()
-- -- 			-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
-- -- 			-- they way you will only jump inside the snippet region
-- -- 		elseif luasnip.expand_or_jumpable() then
-- -- 			luasnip.expand_or_jump()
-- -- 		elseif has_words_before() then
-- -- 			cmp.complete()
-- -- 		else
-- -- 			fallback()
-- -- 		end
-- -- 	end, { "i", "s" }),
-- -- 	["<C-Space>"] = cmp.mapping.complete(),
-- -- })
-- -- cmp_mappings['<CR>'] = nil

-- -- lsp.setup_nvim_cmp({
-- -- 	mapping = cmp_mappings,
-- -- 	-- make snippets have higher priority
-- -- 	sources = cmp.config.sources({
-- -- 		{ name = "luasnip", option = { show_autosnippets = true } },
-- -- 		{ name = "nvim_lsp" },
-- -- 	}, {
-- -- 		{ name = "path" },
-- -- 		-- { name = "buffer" },
-- -- 	}),
-- -- 	enabled = function()
-- -- 		-- disable completion in comments
-- -- 		local context = require("cmp.config.context")
-- -- 		-- keep command mode completion enabled when cursor is in a comment
-- -- 		if vim.api.nvim_get_mode().mode == "c" then
-- -- 			return true
-- -- 		else
-- -- 			return not context.in_treesitter_capture("string") and not context.in_syntax_group("String")
-- -- 		end
-- -- 	end,
-- -- })

-- require("lsp_signature").setup({ max_width = 1000 })

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
		vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "<leader>r",   vim.lsp.buf.rename,                  opts)
		vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
		-- 		-- stylua: ignore end

		-- 		-- vim.keymap.set('i', "<C-p>", function() cmp.mapping.select_prev_item(cmp_select) end, opts);
		-- 		-- ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),

		-- 		-- if cmp.visible() then
		-- 		-- 	-- no idea why complete doesnt work here
		-- 		-- 	-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
		-- 		-- 	cmp.select_next_item(cmp_select)
		-- 		-- 	cmp.complete({ select = true })
		-- 		-- 	-- cmp.select_next_item()
		-- 		-- 	-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
		-- 		-- 	-- they way you will only jump inside the snippet region
		-- 		-- elseif luasnip.expand_or_jumpable() then
		-- 		-- 	luasnip.expand_or_jump()
		-- 		-- elseif has_words_before() then
		-- 		-- 	cmp.complete()
		-- 		-- else
		-- 		-- 	fallback()
		-- 		-- end
		-- 		-- end, { "i", "s" }),
		-- 		-- ["<C-Space>"] = cmp.mapping.complete(),
		-- 		-- })
		-- 		-- cmp_mappings['<CR>'] = nil

		-- 		-- For now let Formatter.nvim handle this

		-- 		if client.name == "omnisharp" then
		-- 			local function toSnakeCase(str)
		-- 				return string.gsub(str, "%s*[- ]%s*", "_")
		-- 			end

		-- 			local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
		-- 			for i, v in ipairs(tokenModifiers) do
		-- 				tokenModifiers[i] = toSnakeCase(v)
		-- 			end
		-- 			local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
		-- 			for i, v in ipairs(tokenTypes) do
		-- 				tokenTypes[i] = toSnakeCase(v)
		-- 			end
		-- 		end

		-- 		-- make these options only work on buffers with active lsp
		-- 		local opts = { buffer = bufnr, remap = false }

		-- 		vim.keymap.set("n", "gd", function()
		-- 			if client.name == "omnisharp" then
		-- 				return omnisharp_extended.telescope_lsp_definitions()
		-- 			end

		-- 			return telescope.lsp_definitions()
		-- 		end, opts)
	end,
})

-- vim.diagnostic.config({
-- 	virtual_text = true,
-- 	underline = true,
-- 	update_in_insert = true,
-- })

vim.api.nvim_create_user_command("EditSnippets", function()
	require("luasnip.loaders").edit_snippet_files()
end, { desc = "Edit available snippets" })
