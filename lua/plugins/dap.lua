return {
	"mfussenegger/nvim-dap",
	lazy = false,
	dependencies = {
		{ "nvim-neotest/nvim-nio" },
		{
			"igorlfs/nvim-dap-view",
			---@module 'dap-view'
			---@type dapview.Config
			opts = {},
		},
		-- {
		-- 	"rcarriga/nvim-dap-ui",
		-- 	opts = {
		-- 		layouts = {
		-- 			{
		-- 				elements = {
		-- 					{ id = "stacks", size = 0.10 },
		-- 					{ id = "breakpoints", size = 0.20 },
		-- 					{ id = "scopes", size = 0.45 },
		-- 					{ id = "watches", size = 0.25 },
		-- 				},
		-- 				position = "left",
		-- 				size = 80,
		-- 			},
		-- 			{
		-- 				elements = { { id = "repl", size = 1 } },
		-- 				position = "bottom",
		-- 				size = 10,
		-- 			},
		-- 		},
		-- 	},
		-- },
		{ "theHamsta/nvim-dap-virtual-text", opts = {} },
	},
	-- stylua: ignore
	keys = {
		{ "<leader>dT", function() require('dap').terminate() end,          desc = "Terminate Dap Session"        },
		-- { "<leader>dd", function() require("dapui").toggle() end,           desc = "Toggle DapUI"                 },
		{ "<leader>dd", function() require("dap-view").toggle() end,           desc = "Toggle DapUI"                 },
		{ "<leader>db", function() require("dap").toggle_breakpoint() end,  desc = "Toggle Breakpoint"            },
		{ "<leader>dr", function() require('dap').repl.open() end,          desc = "Open Repl"                    },
		{ "<leader>di", function() require('dap').step_into() end,          desc = "Step Into"                    },
		{ "<leader>do", function() require('dap').step_over()end,           desc = "Step Over"                    },
		{ "<leader>dO", function() require('dap').step_out() end,           desc = "Step Out"                     },
		{ "<leader>dn", function() require('dap').continue() end,           desc = "Step Continue"                },
		{ "<leader>dk", function() require('dap.ui.widgets').hover() end,   desc = "Hover"                        },
		{ "<leader>dp", function() require('dap.ui.widgets').preview() end, desc = "Preview"                      },
		{ "<leader>de", function() require('dapui').eval() end,             desc = "Evaluate", mode = "v"         },
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dap-view")

		dap.listeners.before.attach.dapui_config = dapui.open
		dap.listeners.before.launch.dapui_config = dapui.open
		dap.listeners.before.event_terminated.dapui_config = dapui.close
		dap.listeners.before.event_exited.dapui_config = dapui.close

		-- local dapui = require("dapui")
		-- dap.listeners.before.attach.dapui_config = dapui.open
		-- dap.listeners.before.launch.dapui_config = dapui.open
		-- dap.listeners.before.event_terminated.dapui_config = dapui.close
		-- dap.listeners.before.event_exited.dapui_config = dapui.close

		dap.adapters.php = {
			type = "executable",
			command = "bash",
			args = { "/home/maru/.local/share/nvim/mason/bin/php-debug-adapter" },
		}

		dap.adapters.node2 = {
			type = "executable",
			command = "node",
			args = { os.getenv("HOME") .. "/.local/lib/vscode-node-debug2/out/src/nodeDebug.js" },
		}
		dap.configurations.javascript = {
			{
				name = "Launch",
				type = "node2",
				request = "launch",
				program = "${file}",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				console = "integratedTerminal",
			},
			{
				-- For this to work you need to make sure the node process is started with the `--inspect` flag.
				name = "Attach to process",
				type = "node2",
				request = "attach",
				processId = require("dap.utils").pick_process,
			},
		}

		dap.configurations.typescript = {
			{
				name = "Launch",
				type = "node2",
				request = "launch",
				cwd = vim.loop.cwd(),
				runtimeArgs = { "-r", "ts-node/register" },
				runtimeExecutable = "node",
				args = { "--inspect", "${file}" },
				sourceMaps = true,
				skipFiles = { "<node_internals>/**", "node_modules/**" },
				outFiles = { "${workspaceRoot/**/*.js" },
			},
			{
				name = "Attach",
				type = "node2",
				request = "attach",
				processId = require("dap.utils").pick_process,

				sourceMaps = true,
				outFiles = { "${workspaceRoot}/build/**/*.js" },
				localRoot = "${workspaceFolder}/",
				remoteRoot = "${workspaceRoot}/build/",
			},
		}

		dap.adapters.coreclr = {
			type = "executable",
			command = "/usr/local/bin/netcoredbg/netcoredbg",
			args = { "--interpreter=vscode" },
		}

		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "launch - netcoredbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
				end,
			},
		}
	end,
}
