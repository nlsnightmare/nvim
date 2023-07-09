local dap = require('dap')
local dapui = require('dapui')

require('nvim-dap-virtual-text').setup {}

dapui.setup {
	controls = {
		enabled = false,
	},
}

vim.keymap.set('n', '<leader>D', dapui.toggle)
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>dr', dap.repl.open)
vim.keymap.set('n', '<F1>', dap.step_into)
vim.keymap.set('n', '<F2>', dap.step_over)
vim.keymap.set('n', '<F3>', dap.step_out)
vim.keymap.set('n', '<F4>', dap.continue)


-- See https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#PHP
dap.adapters.php = {
	type = 'executable',
	command = 'node',
	args = { '/home/maru/.local/share/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = { {
	type = 'php',
	request = 'launch',
	name = 'Listen for Xdebug',
	port = 9003
} }


dap.adapters.coreclr = {
	type = 'executable',
	command = '/usr/local/bin/netcoredbg/netcoredbg',
	args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
	{
		type = "coreclr",
		name = "launch - netcoredbg",
		request = "launch",
		program = function()
			return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
		end,
	},
}
