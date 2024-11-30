return require('packer').startup(function(use)
	-- COLOR SCHEMES:
	use 'shaunsingh/nord.nvim'
	use { "catppuccin/nvim", as = "catppuccin" }
	use 'Mofiqul/dracula.nvim'
	use { 'rose-pine/neovim', as = 'rose-pine' }
	use { "ellisonleao/gruvbox.nvim" }
	use { "folke/tokyonight.nvim" }
	-- for some reason, this theme uses PaperColor as the name
	use { "NLKNguyen/papercolor-theme", as = "papercolor" }
	
	-- status line thing:
	use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'nvim-tree/nvim-web-devicons' }
	}

	-- file tree
	use { "nvim-tree/nvim-tree.lua" }
	use { "nvim-tree/nvim-web-devicons" } -- icons

	-- treesitter thing
	use { "nvim-treesitter/nvim-treesitter" }

	-- lsp configuration thing
	use { "neovim/nvim-lspconfig" }

	-- nvim-cmp (for autocomplete)
	use { "hrsh7th/nvim-cmp" }
	use { "hrsh7th/cmp-nvim-lsp" }

	-- auto pairing thing
	use {
		"windwp/nvim-autopairs",
	    config = function() require("nvim-autopairs").setup {} end
	}

	-- snippets stuff
	use { 'saadparwaiz1/cmp_luasnip' } -- Snippets source for nvim-cmp
	use { 'L3MON4D3/LuaSnip' } -- Snippets plugin

	-- debugger stuff
	-- use { 'mfussenegger/nvim-dap' }
	
	-- LaTeX plugin
	use { 'lervag/vimtex' }
	-- thing for LaTeX autocomplete
	use { 'micangl/cmp-vimtex' }

	-- fuzzy finder stuff
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim' } }
	}
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

	-- git stuff
	use { 'lewis6991/gitsigns.nvim' }

	-- cmake thing
	use 'Civitasv/cmake-tools.nvim'

	-- debugger thing
	use 'mfussenegger/nvim-dap'
	
	-- ui for nvim-dap
	use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }

	-- vim practice game
	use { 'ThePrimeagen/vim-be-good' }
end)
