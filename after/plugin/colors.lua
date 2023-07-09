function SetColorScheme(color)
	color = color or "rose-pine"
	require('rose-pine').setup { variant = 'moon' }
	require('ayu').setup { mirage = true }
	require('catppuccin').setup {}
	-- TODO: 

	-- vim.cmd('colorscheme color')
	vim.cmd('colorscheme ' .. color)
end

SetColorScheme("catppuccin-macchiato")
