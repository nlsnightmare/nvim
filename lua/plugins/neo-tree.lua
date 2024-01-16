return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	keys = {
		{ "<leader>F", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	config = {
		filesystem = {
			follow_current_file = {
				enabled = true,
				leave_dirs_open = false,
			},
			hijack_netrw_behavior = "open_current",
		},
		window = {
			mappings = {
				["<tab>"] = { "toggle_node", nowait = false, },
				["z"] = "",
				["zM"] = "close_all_nodes",
				["Z"] = "expand_all_nodes",
			},
		},
	},
}
