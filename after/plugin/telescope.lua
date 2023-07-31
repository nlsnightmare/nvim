local builtin = require("telescope.builtin")

require("telescope").setup({
	pickers = {
		buffers = {
			sort_lastused = true,
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_cursor({}),
		},
	},
})

vim.keymap.set("n", "<C-h>", builtin.keymaps, {})
vim.keymap.set("n", "<C-e>", builtin.find_files, {})
vim.keymap.set("n", "<C-b>", builtin.buffers, {})
vim.keymap.set("n", "<C-f>", function()
	builtin.grep_string({ search = vim.fn.input("GREP> ") })
end)

-- These are currently set in the lsp config file
-- vim.keymap.set('n', '<F12>', builtin.lsp_definitions)
vim.keymap.set("n", "gr", builtin.lsp_references)
vim.keymap.set("n", "<F12>", builtin.lsp_implementations)
vim.keymap.set("n", "<C-p>", builtin.commands)
vim.keymap.set("n", "<leader>t", builtin.builtin)
vim.keymap.set("n", "[?", builtin.diagnostics)

require("telescope").load_extension("ui-select")
