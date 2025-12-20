function SetColorScheme(color)
	color = color or "rose-pine"
	require("rose-pine").setup({ variant = "moon" })
	require("ayu").setup({ mirage = true })
	require("catppuccin").setup({})
	-- TODO:

	-- vim.cmd('colorscheme color')
	vim.cmd("colorscheme " .. color)
end

local isWsl = false
local io = require("io")
local file = io.open("/etc/wsl.conf")
if file ~= nil then
	io.close(file)
	isWsl = true
end

-- SetColorScheme("ayu-mirage")

if isWsl then
	SetColorScheme("catppuccin-frappe")
else
	SetColorScheme("catppuccin-frappe")
end
-- end
