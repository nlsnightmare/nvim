local function leap()
	require("leap").leap({ target_windows = { vim.api.nvim_get_current_win() } })
end

return {
	"ggandor/leap.nvim",
	keys = {
		{ "<leader>s", leap },
	},
}
