local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

vim.cmd([[
augroup packer_user_config
  autocmd!
  autocmd BufWritePost packer.lua source <afile> | PackerCompile
augroup end]])

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim" })

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		requires = { "nvim-lua/plenary.nvim" },
	})
	use({ "nvim-telescope/telescope-ui-select.nvim" })
	use({ "nvim-telescope/telescope-symbols.nvim" })

	use({
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				input = {
					enabled = true,
					default_prompt = "> ",
					start_in_insert = false,
				},
				select = { enabled = false },
			})
		end,
	})

	use({ "mhinz/vim-startify" })

	-- Themes
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({ "rose-pine/neovim", as = "rose-pine" })
	use({ "Shatur/neovim-ayu", as = "ayu" })
	use({ "folke/tokyonight.nvim", as = "tokyonight" })

	use({ "rebelot/kanagawa.nvim", as = "kanagawa" })
	use({ "embark-theme/vim", as = "embark" })
	use("EdenEast/nightfox.nvim")

	-- Symbol bar
	use({
		"utilyre/barbecue.nvim",
		tag = "*",
		requires = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		after = "nvim-web-devicons", -- keep this if you're using NvChad
		config = function()
			require("barbecue").setup()
		end,
	})

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	use({ "nvim-treesitter/nvim-treesitter", as ="treesitter", { run = ":TSUpdate" } })
	use({ "nvim-treesitter/playground" })
	use({ "IndianBoy42/tree-sitter-just" })

	-- Unfortunately, treesitter doen't razor or blade syntax yet
	use({ "jlcrochet/vim-razor" })
	use({ "jwalton512/vim-blade" })

	-- file explorer
	use({ "nvim-tree/nvim-tree.lua" })

	-- Make Editing Easier
	use({ "easymotion/vim-easymotion" })
	use({ "tpope/vim-surround" })
	use("jiangmiao/auto-pairs")
	use({ "tpope/vim-commentary" })
	use({ "junegunn/vim-easy-align" })

	-- use { 'utilyre/sentiment.nvim', config = function()
	-- 	require("sentiment").setup {}
	-- end }

	use("tpope/vim-fugitive")

	use({ "mhartington/formatter.nvim" })

	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	})

	-- mkdir when missing
	use({ "jghauser/mkdir.nvim" })

	-- Go easy on the eyes
	use({ "folke/zen-mode.nvim", as = "zen-mode" })

	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			{ "Hoffs/omnisharp-extended-lsp.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-buffer" }, -- Optional
			{ "hrsh7th/cmp-path" }, -- Optional
			{ "saadparwaiz1/cmp_luasnip" }, -- Optional
			{ "Issafalcon/lsp-overloads.nvim" },

			{ "hrsh7th/cmp-nvim-lua" }, -- Optional

			-- Snippets
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" }, -- Optional
		},
	})
	use({
		"dgagn/diagflow.nvim",
		config = function()
			require("diagflow").setup()
		end,
	})
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use({ "theHamsta/nvim-dap-virtual-text" })

	if packer_bootstrap then
		require("packer").sync()
	end
end)
