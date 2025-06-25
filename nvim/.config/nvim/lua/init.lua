-- install lazy.nvim if not installed
require("config.lazy")

-- disable netrw (for nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- improves colors I think
vim.opt.termguicolors = true

local signs = {
	ERROR = "",
	WARN = "",
	HINT = "",
	INFO = ""
}

vim.diagnostic.config({
	float = {
		header = "Diagnostics: (gra for actions)",
		border = "rounded",
		focusable = false,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = signs.ERROR,
			[vim.diagnostic.severity.WARN] = signs.WARN,
			[vim.diagnostic.severity.HINT] = signs.HINT,
			[vim.diagnostic.severity.INFO] = signs.INFO,
		},
	},
	severity_sort = true,
})

-- seems to be the cleanest way to set rounded borders in all floating lsp windows
-- got from here: https://github.com/ofseed/nvim/blob/91484d1a7a8d01f8ee9c792f3fcd9a96232a4cf1/lua/lsp.lua#L25-L32 and some other place I think
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

--[[
-- lualine stuff
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

require('lualine').setup()

-- file tree thing
-- they suggest disabling netrw (idek what it is)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- this does something... maybe
vim.opt.termguicolors = true

require('nvim-tree').setup()

-- treesitter thing
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "cpp", "python" },
	
	highlight = {
		enable = true
	}
}

-- LSP setup
-- require'lspconfig'.clangd.setup{}

-- keybinds for lsp
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('UserLspConfig', {}),
--   callback = function(ev)
--     -- Enable completion triggered by <c-x><c-o>
--     vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
-- 
--     -- Buffer local mappings.
--     -- See `:help vim.lsp.*` for documentation on any of the below functions
--     local opts = { buffer = ev.buf }
--     vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
--     vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
--     vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
--     vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
--     vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
--     vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
--     vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
--     vim.keymap.set('n', '<space>wl', function()
--       print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--     end, opts)
--     vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
--     vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
--     vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
--     vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--     vim.keymap.set('n', '<space>f', function()
--       vim.lsp.buf.format { async = true }
--     end, opts)
--   end,
-- })

-- from https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

-- desired language servers (maybe add more?)
local servers = { 'clangd' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- snippet thang
local luasnip = require 'luasnip'

-- make a few snippets for latex
luasnip.add_snippets(nil, {
	tex = {
		luasnip.snippet({
			trig = "\\bmat",
			namr = "bmatrix",
		}, {
			luasnip.text_node({"\\begin{bmatrix}"}),
			luasnip.insert_node(1),
			luasnip.text_node({"\\end{bmatrix}"}),
			luasnip.insert_node(0),
		}),
		luasnip.snippet({
			trig = "\\frac",
			namr = "frac",
		}, {
			luasnip.text_node({"\\frac{"}),
			luasnip.insert_node(1),
			luasnip.text_node({"}{"}),
			luasnip.insert_node(2),
			luasnip.text_node({"}"}),
			luasnip.insert_node(0),
		}),
		luasnip.snippet({
			trig = "\\vec",
			namr = "vec",
		}, {
			luasnip.text_node({"\\vec{"}),
			luasnip.insert_node(1),
			luasnip.text_node({"}"}),
			luasnip.insert_node(0),
		}),

	},
})

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
	snippet = {
    	expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
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
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
    	  	else
    	  		fallback()
    	  	end
    	end, { 'i', 's' }),
    	['<S-Tab>'] = cmp.mapping(function(fallback)
    		if cmp.visible() then
    			cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
    		else
    			fallback()
    		end
    	end, { 'i', 's' }),
	}),
	sources = {
		{ name = 'buffer' },
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' }
	},
}
cmp.setup.filetype("tex", {
	sources = {
		{ name = 'vimtex' },
		{ name = 'buffer' },
		{ name = 'luasnip' }
	},
})

-- fuzzy finder setup
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
-- Disable folding in Telescope's result window.
--]]
-- vim.api.nvim_create_autocmd("FileType", { pattern = "TelescopeResults", command = [[setlocal nofoldenable]] })

-- git thing
--[[
require('gitsigns').setup()

-- cmake thing
require("cmake-tools").setup {
  cmake_command = "cmake", -- this is used to specify cmake command path
  ctest_command = "ctest", -- this is used to specify ctest command path
  cmake_regenerate_on_save = true, -- auto generate when save CMakeLists.txt
  cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
  cmake_build_options = {}, -- this will be passed when invoke `CMakeBuild`
  -- support macro expansion:
  --       ${kit}
  --       ${kitGenerator}
  --       ${variant:xx}
  cmake_build_directory = "out/${variant:buildType}", -- this is used to specify generate directory for cmake, allows macro expansion, relative to vim.loop.cwd()
  cmake_soft_link_compile_commands = true, -- this will automatically make a soft link from compile commands file to project root dir
  cmake_compile_commands_from_lsp = false, -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
  cmake_kits_path = nil, -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
  cmake_variants_message = {
    short = { show = true }, -- whether to show short message
    long = { show = true, max_length = 40 }, -- whether to show long message
  },
  cmake_dap_configuration = { -- debug settings for cmake
    name = "cpp",
    type = "codelldb",
    request = "launch",
    stopOnEntry = false,
    runInTerminal = true,
    console = "integratedTerminal",
  },
  cmake_executor = { -- executor to use
    name = "quickfix", -- name of the executor
    opts = {}, -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
    default_opts = { -- a list of default and possible values for executors
      quickfix = {
        show = "always", -- "always", "only_on_error"
        position = "belowright", -- "vertical", "horizontal", "leftabove", "aboveleft", "rightbelow", "belowright", "topleft", "botright", use `:h vertical` for example to see help on them
        size = 10,
        encoding = "utf-8", -- if encoding is not "utf-8", it will be converted to "utf-8" using `vim.fn.iconv`
        auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
      },
      toggleterm = {
        direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
        close_on_exit = false, -- whether close the terminal when exit
        auto_scroll = true, -- whether auto scroll to the bottom
      },
      overseer = {
        new_task_opts = {
            strategy = {
                "toggleterm",
                direction = "horizontal",
                autos_croll = true,
                quit_on_exit = "success"
            }
        }, -- options to pass into the `overseer.new_task` command
        on_new_task = function(task)
            require("overseer").open(
                { enter = false, direction = "right" }
            )
        end,   -- a function that gets overseer.Task when it is created, before calling `task:start`
      },
      terminal = {
        name = "Main Terminal",
        prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
        split_direction = "horizontal", -- "horizontal", "vertical"
        split_size = 11,

        -- Window handling
        single_terminal_per_instance = true, -- Single viewport, multiple windows
        single_terminal_per_tab = true, -- Single viewport per tab
        keep_terminal_static_location = true, -- Static location of the viewport if avialable

        -- Running Tasks
        start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
        focus = false, -- Focus on terminal when cmake task is launched.
        do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
      }, -- terminal executor uses the values in cmake_terminal
    },
  },
  cmake_runner = { -- runner to use
    name = "terminal", -- name of the runner
    opts = {}, -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
    default_opts = { -- a list of default and possible values for runners
      quickfix = {
        show = "always", -- "always", "only_on_error"
        position = "belowright", -- "bottom", "top"
        size = 10,
        encoding = "utf-8",
        auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
      },
      toggleterm = {
        direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
        close_on_exit = false, -- whether close the terminal when exit
        auto_scroll = true, -- whether auto scroll to the bottom
      },
      overseer = {
        new_task_opts = {
            strategy = {
                "toggleterm",
                direction = "horizontal",
                autos_croll = true,
                quit_on_exit = "success"
            }
        }, -- options to pass into the `overseer.new_task` command
        on_new_task = function(task)
        end,   -- a function that gets overseer.Task when it is created, before calling `task:start`
      },
      terminal = {
        name = "Main Terminal",
        prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
        split_direction = "horizontal", -- "horizontal", "vertical"
        split_size = 11,

        -- Window handling
        single_terminal_per_instance = true, -- Single viewport, multiple windows
        single_terminal_per_tab = true, -- Single viewport per tab
        keep_terminal_static_location = true, -- Static location of the viewport if avialable

        -- Running Tasks
        start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
        focus = false, -- Focus on terminal when cmake task is launched.
        do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
      },
    },
  },
  cmake_notifications = {
    runner = { enabled = true },
    executor = { enabled = true },
    spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
    refresh_rate_ms = 100, -- how often to iterate icons
  },
}

-- gdb thing for nvim-dap
local dap = require("dap")
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" }
}

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb'
}

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = '/bin/codelldb',
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}

dap.configurations.cpp = {
	{
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
}

--dap.configurations.cpp = {
--  {
--    name = 'Launch',
--    type = 'lldb',
--    request = 'launch',
--    program = function()
--      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--    end,
--    cwd = '${workspaceFolder}',
--    stopOnEntry = false,
--    args = {},
--
--    -- 💀
--    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
--    --
--    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
--    --
--    -- Otherwise you might get the following error:
--    --
--    --    Error on launch: Failed to attach to the target process
--    --
--    -- But you should be aware of the implications:
--    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
--    -- runInTerminal = false,
--  },
--}

require("dapui").setup()
--]]
-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

