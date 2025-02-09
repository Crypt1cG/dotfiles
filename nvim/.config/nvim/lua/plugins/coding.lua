return {
	-- auto pairing
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter", -- I guess this means it will be loaded when I enter insert mode
		config = true, -- not really sure what this is/does
	},

	-- treesitter - not really sure of the full extent of this plugin, but at the very least, it makes syntax highlighting better
	{
		"nvim-treesitter/nvim-treesitter",
		version = false, -- I got this from LazyVim config
		build = ":TSUpdate", -- I think this automates updating treesitter stuff
		opts = {
			ensure_installed = { "c", "cpp", "python", "cmake", "make" },
			highlight = { enable = true },
		},
		config = function (_, opts) 
			local configs = require("nvim-treesitter.configs")

			configs.setup(opts)
		end
	},

	-- nvim-cmp stuff
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			cmp.setup {
				-- snippet = {
				-- 	expand = function(args)
				-- 		luasnip.lsp_expand(args.body)
				-- 	end,
				-- },
				mapping = cmp.mapping.preset.insert({
					['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
					['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
					-- C-b (back) C-f (forward) for snippet placeholder navigation.
					['<C-Space>'] = cmp.mapping.complete(),
					['<CR>'] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					},
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						-- elseif luasnip.expand_or_jumpable() then
						-- 	luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						-- elseif luasnip.jumpable(-1) then
						-- 	luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
				}),
				sources = {
					{ name = 'buffer' },
					{ name = 'nvim_lsp' },
					--{ name = 'luasnip' }
				},
			}
			cmp.setup.filetype("tex", {
				sources = {
					{ name = "vimtex" },
					{ name = "buffer" },
					-- { name = "luasnip" },
				}
			})
		end
	},
	
	-- more nvim-cmp
	-- TODO: look into this - is this actually good?
	{
		"hrsh7th/cmp-nvim-lsp",
	},

	-- lsp configuration thing - TODO: idk what this does
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local servers = { "clangd", "pyright", }
			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup {
					capabilities = capabilities,
				}
			end
		end
	},

	-- latex support
	{
		"lervag/vimtex",
		-- apparently I could put config here for like zathura
	},

	-- latex autocomplete - maybe look into alternatives to this
	{
		"micangl/cmp-vimtex"
	},
}
