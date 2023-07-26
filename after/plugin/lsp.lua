local lsp = require("lsp-zero")
local util = require("lspconfig.util")
local omnisharp_extended = require("omnisharp_extended")
local telescope = require("telescope.builtin")

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"rust_analyzer",
	"intelephense",
	"lua_ls",
})

-- Fix Undefined global 'vim'
lsp.configure("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

lsp.configure("omnisharp", {
	handlers = {
		["textDocument/definition"] = omnisharp_extended.handler,
	},
})

-- Prevent the server from moving things around
local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			-- no idea why complete doesnt work here
			-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
			cmp.select_next_item(cmp_select)
			cmp.complete({ select = true })
			-- cmp.select_next_item()
			-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
			-- they way you will only jump inside the snippet region
		elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		elseif has_words_before() then
			cmp.complete()
		else
			fallback()
		end
	end, { "i", "s" }),
	["<C-Space>"] = cmp.mapping.complete(),
})
-- cmp_mappings['<CR>'] = nil

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
	-- make snippets have higher priority
	sources = cmp.config.sources({
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
	}, {
		{ name = "path" },
		{ name = "buffer" },
	}),
})

lsp.on_attach(function(client, bufnr)
	--- Guard against servers without the signatureHelper capability
	if client.server_capabilities.signatureHelpProvider then
		require("lsp-overloads").setup(client, {})

		vim.api.nvim_set_keymap("i", "<C-h>", "<cmd>LspOverloadsSignature<CR>", { noremap = true, silent = false })
	end

	-- @see https://github.com/OmniSharp/omnisharp-roslyn/issues/2483#issuecomment-1546721190
	if client.name == "omnisharp" then
		local function toSnakeCase(str)
			return string.gsub(str, "%s*[- ]%s*", "_")
		end

		local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
		for i, v in ipairs(tokenModifiers) do
			tokenModifiers[i] = toSnakeCase(v)
		end
		local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
		for i, v in ipairs(tokenTypes) do
			tokenTypes[i] = toSnakeCase(v)
		end
	end

	-- make these options only work on buffers with active lsp
	local opts = { buffer = bufnr, remap = false }

	-- huh? looks like lsp disables autoindent
	vim.opt.autoindent = true

	vim.keymap.set("n", "gd", function()
		if client.name == "omnisharp" then
			return omnisharp_extended.telescope_lsp_definitions()
		end

		return telescope.lsp_definitions()
	end, opts)

	vim.keymap.set("n", "gr", telescope.lsp_references)
	-- stylua: ignore start
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	-- stylua: ignore end

	-- For now let Formatter.nvim handle this
	-- vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
end)

lsp.setup()
vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_user_command("EditSnippets", function()
	require("luasnip.loaders").edit_snippet_files()
end, { desc = "Edit available snippets" })
