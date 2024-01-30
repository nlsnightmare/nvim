return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-telescope/telescope-symbols.nvim",
	},
	keys = {
		{ "<C-S-p>", ":Telescope builtin<CR>" },
		{ "<C-h>", ":Telescope keymaps<CR>" },
		{ "<C-e>", ":Telescope find_files<CR>" },
		{ "<C-b>", ":Telescope buffers<CR>" },
		{ "gr", ":Telescope lsp_references<cr>", desc = "LSP references" },
		{ "<F12>", ":Telescope lsp_implementations<cr>", desc = "LSP Implementations" },
		{ "<C-p>", ":Telescope commands<cr>", desc = "Commands " },
		{ "<leader>t", ":Telescope builtin<cr>", desc = "Telescope Builtin" },
		{ "[?", ":Telescope diagnostics<cr>", desc = "Diagnostics" },
		{ "<C-f>", ':lua require("telescope.builtin").grep_string({ search = vim.fn.input("GREP> ") })<CR>' },
	},
	opts = {
		pickers = {
			buffers = {
				sort_lastused = true,
				mappings = {
					n = {
						["<C-d>"] = "delete_buffer",
					},
					i = {
						["<C-h>"] = "which_key",
						["<C-d>"] = "delete_buffer",
					},
				},
			},
		},
		extensions = {
			["ui-select"] = {
				-- require("telescope.themes").get_cursor({}),
			},
		},
	},
}
