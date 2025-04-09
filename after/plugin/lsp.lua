local lsp = require("lsp-zero")
local util = require("lspconfig.util")
local omnisharp_extended = require("omnisharp_extended")
local telescope = require("telescope.builtin")

lsp.preset("recommended")

lsp.ensure_installed({
	"ts_ls",
	"rust_analyzer",
	"intelephense",
	"lua_ls",
	"emmet_ls",
})

lsp.configure("html_ls", {
	filetypes = { "html", "cshtml", "blade", "htmlangular" },
})

lsp.configure("emmet_ls", {
	filetypes = {
		"css",
		"eruby",
		"html",
		"cshtml",
		"javascript",
		"javascriptreact",
		"htmlangular",
		"less",
		"sass",
		"scss",
		"pug",
		"typescriptreact",
		"blade",
	},
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
		["textDocument/definition"] = function(...)
			return require("omnisharp_extended").handler(...)
		end,
	},
	keys = {
		{
			"gd",
			function()
				require("omnisharp_extended").telescope_lsp_definitions()
			end,
			desc = "Goto Definition",
		},
	},
	enable_roslyn_analyzers = true,
	organize_imports_on_format = true,
	enable_import_completion = true,
})

lsp.configure("csharp_ls", {
	filetypes = { "cs", "razor", "cshtml", "csproj" },
})

-- Prevent the server from moving things around
local cmp = require("cmp")
local luasnip = require("luasnip")
luasnip.config.setup({
	enable_autosnippets = true,
	region_check_events = "CursorHold,InsertLeave",
	-- those are for removing deleted snippets, also a common problem
	delete_check_events = "TextChanged,InsertEnter",
})

local cmp_select = { behavior = cmp.SelectBehavior.Select }
require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "./snippets" } })

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
		{ name = "luasnip", option = { show_autosnippets = true } },
		{ name = "nvim_lsp" },
	}, {
		{ name = "path" },
		-- { name = "buffer" },
	}),
	enabled = function()
		-- disable completion in comments
		local context = require("cmp.config.context")
		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("string") and not context.in_syntax_group("String")
		end
	end,
})

require("lsp_signature").setup({
	max_width = 1000,
})
lsp.on_attach(function(client, bufnr)
	--- Guard against servers without the signatureHelper capability
	if client.server_capabilities.signatureHelpProvider then
		-- require("lsp-overloads").setup(client, {
		-- 	-- UI options are mostly the same as those passed to vim.lsp.util.open_floating_preview
		-- 	ui = {
		-- 		border = "single", -- The border to use for the signature popup window. Accepts same border values as |nvim_open_win()|.
		-- 		height = nil, -- Height of the signature popup window (nil allows dynamic sizing based on content of the help)
		-- 		width = nil, -- Width of the signature popup window (nil allows dynamic sizing based on content of the help)
		-- 		wrap = true, -- Wrap long lines
		-- 		wrap_at = nil, -- Character to wrap at for computing height when wrap enabled
		-- 		max_width = nil, -- Maximum signature popup width
		-- 		max_height = nil, -- Maximum signature popup height
		-- 		-- Events that will close the signature popup window: use {"CursorMoved", "CursorMovedI", "InsertCharPre"} to hide the window when typing
		-- 		close_events = { "CursorMoved", "BufHidden", "InsertLeave" },
		-- 		focusable = true, -- Make the popup float focusable
		-- 		focus = false, -- If focusable is also true, and this is set to true, navigating through overloads will focus into the popup window (probably not what you want)
		-- 		offset_x = 0, -- Horizontal offset of the floating window relative to the cursor position
		-- 		offset_y = 0, -- Vertical offset of the floating window relative to the cursor position
		-- 		floating_window_above_cur_line = false, -- Attempt to float the popup above the cursor position
		-- 		-- (note, if the height of the float would be greater than the space left above the cursor, it will default
		-- 		-- to placing the float below the cursor. The max_height option allows for finer tuning of this)
		-- 		silent = true, -- Prevents noisy notifications (make false to help debug why signature isn't working)
		-- 		-- Highlight options is null by default, but this just shows an example of how it can be used to modify the LspSignatureActiveParameter highlight property
		-- 		highlight = {
		-- 			italic = true,
		-- 			bold = true,
		-- 			fg = "#ffffff",
		-- 		},
		-- 	},
		-- 	keymaps = {
		-- 		next_signature = "<C-j>",
		-- 		previous_signature = "<C-k>",
		-- 		next_parameter = "<C-l>",
		-- 		previous_parameter = "<C-h>",
		-- 		close_signature = "<A-s>",
		-- 	},
		-- 	display_automatically = true, -- Uses trigger characters to automatically display the signature overloads when typing a method signature
		-- })
		-- vim.api.nvim_set_keymap("n", "<C-h>", "<cmd>LspOverloadsSignature<CR>", { noremap = true, silent = false })
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

	-- Open definition in vsplit
	vim.keymap.set("n", "gD", ":vsp<cr><C-]>", opts)

	vim.keymap.set("n", "gr", telescope.lsp_references)
	-- stylua: ignore start
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
	-- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	-- stylua: ignore end

	-- For now let Formatter.nvim handle this
	-- vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
end)

lsp.setup()
vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_user_command("EditSnippets", function()
	require("luasnip.loaders").edit_snippet_files()
end, { desc = "Edit available snippets" })
