vim.g.startify_commands = {
	{ U = { "Update Plugins", ":PackerSync" } },
}

vim.g.startify_bookmarks = {
	{ z = "~/.zshrc" },
	{ v = "~/.config/nvim/lua/maru/packer.lua" },
	{ i = "~/.config/i3/config" },
	{ b = "~/.config/bspwm/bspwmrc" },
	{ x = "~/.Xresources" },
}
vim.g.startify_lists = {
	{ type = "commands", header = { "   Commands" } },
	{ type = "bookmarks", header = { "   Bookmarks" } },
	{ type = "files", header = { "   MRU" } },
	{ type = "sessions", header = { "   Sessions" } },
}
vim.g.startify_session_persistence = 1
vim.g.startify_change_to_dir = 0
vim.g.startify_change_to_vcs_root = 1

-- Start ZenMode when Startify is ready
-- vim.cmd("autocmd User StartifyReady ZenMode")
