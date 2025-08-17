local lazy = require("nxvim.plugins.lazy")

vim.g.multigrid = vim.api.nvim_list_uis()[1].ext_multigrid

-- == [ Modules ===============================================================

---@class NxModule : LazyPluginSpec
---@diagnostic disable-next-line: duplicate-doc-field
---@field config? fun()|boolean|string @add `string` as possible config type.
---@field eager? boolean

---@type string[]|NxModule[]
local modules = {
	-- Tip: use `gf` over a `config = "<path>"` to go to its location

	-- Core ----------------------------------------------------------------------
	{ "nxvim/colorschemes", virtual = true, priority = 90, config = "colorschemes", eager = true },
	{ "nxvim/client", virtual = true, priority = 95, config = "client", eager = true },
	{ "nxvim/keymaps", virtual = true, priority = 80, config = "keymaps", eager = true },
	{ "nxvim/autocmds", virtual = true, priority = 80, config = "autocmds", eager = true },
	{ "nxvim/options", virtual = true, priority = 80, config = "options", eager = true },
	{ "nxvim/lsp", virtual = true, priority = 80, config = "lsp" },
	{ "tenxsoydev/nx.nvim", priority = 100, config = function() _G.nx = require("nx") end, eager = true },
	{ "folke/lazy.nvim" },

	-- Miscellaneous -------------------------------------------------------------
	-- Dashboard
	{ "goolord/alpha-nvim", config = "plugins.alpha", eager = true },
	-- Statusline
	{ "windwp/windline.nvim", config = "plugins.windline", eager = true },
	-- { "tenxsoydev/galaxyline.nvim", branch = "feature-multi-lsp", config = "plugins.galaxyline", eager = true },
	-- Commandline
	{ "gelguy/wilder.nvim", dependencies = "romgrk/fzy-lua-native", event = "CmdlineEnter", config = "plugins.wilder" },
	{ "folke/noice.nvim", config = not vim.g.multigrid and "plugins.noice" or false },
	-- Messages
	{ "AckslD/messages.nvim", event = "VeryLazy", config = vim.g.multigrid and "plugins.messages" or false },
	{ "rcarriga/nvim-notify", config = vim.g.multigrid and "plugins.notify" or false },
	-- File Tree
	{ "nvim-neo-tree/neo-tree.nvim", dependencies = "MunifTanjim/nui.nvim", config = "plugins.neo-tree", eager = true },
	-- Terminal
	{ "akinsho/toggleterm.nvim", event = "VeryLazy", config = "plugins.toggleterm" },
	{ "willothy/flatten.nvim", priority = 100, config = "plugins.flatten" },
	-- Comments
	{ "numToStr/Comment.nvim", event = "VeryLazy", config = "plugins.comment" },
	{ "folke/todo-comments.nvim", event = "VeryLazy", config = "plugins.todo-comments" },
	-- Yank & Register Handling
	{ "tversteeg/registers.nvim", event = "VeryLazy", config = "plugins.registers" },
	{ "tenxsoydev/karen-yank.nvim", event = "VeryLazy", opts = {} },

	-- Buffer- & Window Management -----------------------------------------------
	-- { "akinsho/bufferline.nvim", config = "plugins.bufferline" },
	{ "romgrk/barbar.nvim", config = "plugins.barbar" },
	{ "Bekaboo/dropbar.nvim", event = "VeryLazy", config = "plugins.dropbar" },
	{ "kwkarlwang/bufresize.nvim", event = "VeryLazy", opts = {} }, -- handle split window sizes on client resize
	{ "gorbit99/codewindow.nvim", event = "VeryLazy", config = "plugins.codewindow" },
	{ "petertriho/nvim-scrollbar", event = "VeryLazy", config = "plugins.scrollbar" },
	{ "s1n7ax/nvim-window-picker", event = "VeryLazy", config = "plugins.window-picker" },
	{ "mrjones2014/smart-splits.nvim", event = "VeryLazy", config = "plugins.smart-splits" },
	{
		"anuvyklack/windows.nvim",
		dependencies = { "anuvyklack/middleclass", "anuvyklack/animation.nvim" },
		event = "VeryLazy",
		config = "plugins.windows",
	},
	{ "christoomey/vim-tmux-navigator", event = "VeryLazy", config = function() vim.keymap.del("", "<C-Bslash>") end },
	{ "folke/zen-mode.nvim", event = "VeryLazy", config = "plugins.zen-mode" },

	-- Git -----------------------------------------------------------------------
	{ "sindrets/diffview.nvim", event = "VeryLazy", config = "plugins.diffview" },
	{ "akinsho/git-conflict.nvim", event = "VeryLazy", config = "plugins.git-conflict" },
	{ "ruifm/gitlinker.nvim", event = "VeryLazy", opts = {} },
	{ "lewis6991/gitsigns.nvim", event = "VeryLazy", config = "plugins.gitsigns" },
	{ "NeogitOrg/neogit", event = "VeryLazy", config = "plugins.neogit" },
	-- { "pwntester/octo.nvim", opts = {} },
	{ "mattn/vim-gist", event = "VeryLazy", config = "plugins.gist" },
	{ "mattn/webapi-vim" },
	-- "ThePrimeagen/git-worktree.nvim",

	-- Treesitter ----------------------------------------------------------------
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = "plugins.treesitter" },
	{ "nvim-treesitter/nvim-treesitter-context", dependencies = "nvim-treesitter/nvim-treesitter" },
	{ "windwp/nvim-ts-autotag", dependencies = "nvim-treesitter/nvim-treesitter" },
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		dependencies = "nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		opts = {},
	},
	{ "nvim-treesitter/playground", dependencies = "nvim-treesitter/nvim-treesitter" },
	{
		"mizlan/iswap.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		config = "plugins.iswap",
	},
	{ "HiPhish/rainbow-delimiters.nvim", config = "plugins.rainbow-delimiters" },
	{
		"aarondiel/spread.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		config = "plugins.spread",
	},
	{ "RRethy/vim-illuminate", dependencies = "nvim-treesitter/nvim-treesitter" },

	-- Telescope -----------------------------------------------------------------
	{ "nvim-telescope/telescope.nvim", config = "plugins.telescope" },
	-- stylua: ignore
	{ "ttytm/telescope-frecency.nvim", branch = "fix/validation-not-possible", dependencies = "kkharji/sqlite.lua", lazy = true },
	{ "nvim-telescope/telescope-fzy-native.nvim", dependencies = "romgrk/fzy-lua-native", lazy = true },
	{ "nvim-telescope/telescope-live-grep-args.nvim", lazy = true },
	{ "nvim-telescope/telescope-media-files.nvim", lazy = true },
	{ "smartpde/telescope-recent-files" },
	{ "tknightz/telescope-termfinder.nvim", lazy = true },

	-- LSP / Formatters ----------------------------------------------------------
	{ "folke/neodev.nvim", opts = {} },
	{ "neovim/nvim-lspconfig", config = "lsp.plugins.lspconfig" },
	{ "nvimtools/none-ls.nvim", config = "lsp.plugins.null-ls" }, -- inject external formatters and linters
	{ "glepnir/lspsaga.nvim", event = "VeryLazy", config = "lsp.plugins.lspsaga" },
	{ "j-hui/fidget.nvim", event = "VeryLazy", config = "lsp.plugins.fidget" },
	{ "ray-x/lsp_signature.nvim", event = "VeryLazy", config = "lsp.plugins.lsp-signature" },
	{ "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim", event = "VeryLazy", config = "lsp.plugins.lsp-toggle" },
	-- stylua: ignore
	{ "zeioth/garbage-day.nvim", dependencies = "neovim/nvim-lspconfig", event = "VeryLazy", conifg = "lsp.plugins.garbage-day" },
	{ "b0o/SchemaStore.nvim", event = "VeryLazy" },
	-- Mason
	{ "williamboman/mason.nvim", config = "lsp.plugins.mason", tag = "v1.11.0" },
	-- stylua: ignore
	{ "williamboman/mason-lspconfig.nvim", dependencies = "williamboman/mason.nvim", config = "lsp.plugins.mason.lspconfig", tag = "v1.32.0" },
	{ "jayp0521/mason-null-ls.nvim", dependencies = "williamboman/mason.nvim" },
	-- { "ThePrimeagen/refactoring.nvim", opts = {} },
	-- "tamago324/nlsp-settings.nvim",
	-- Language Specific
	-- Rust
	{ "saecki/crates.nvim", event = "VeryLazy", opts = {} },
	-- Python
	{ "linux-cultist/venv-selector.nvim", branch = "regexp", event = "VeryLazy", config = "plugins.venv-selector" },
	-- Onyx
	"onyx-lang/onyx.vim",

	-- Debug ---------------------------------------------------------------------
	-- TODO: Push DAP config
	"mfussenegger/nvim-dap",
	{ "theHamsta/nvim-dap-virtual-text", opts = {} },
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
	-- "Pocco81/DAPInstall.nvim",
	{ "leoluz/nvim-dap-go", opts = {} },
	{ "folke/trouble.nvim", event = "VeryLazy", config = "plugins.trouble" },
	{ "kevinhwang91/nvim-bqf", event = "VeryLazy", config = "plugins.bqf" },

	-- Code Completion -----------------------------------------------------------
	-- { "saghen/blink.cmp", version = "v0.*", opts = {} },
	{ "hrsh7th/nvim-cmp", event = "InsertEnter", config = "plugins.cmp" },
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-emoji",
	"chrisgrieser/cmp-nerdfont",
	"hrsh7th/cmp-nvim-lua",
	{ "tzachar/cmp-tabnine", build = "./install.sh", config = "plugins.tabnine" },
	{ "Exafunction/codeium.vim", event = "InsertEnter", config = "plugins.codeium" },
	-- { "zbirenbaum/copilot.lua", config = "plugins.copilot" },
	-- { "zbirenbaum/copilot-cmp", dependencies = "zbirenbaum/copilot.lua", opts = {} },
	{ "roobert/tailwindcss-colorizer-cmp.nvim", opts = {} },
	-- Snippets
	{ "L3MON4D3/LuaSnip", event = "VeryLazy", config = "plugins.luasnip" }, --snippet engine
	"saadparwaiz1/cmp_luasnip",
	"rafamadriz/friendly-snippets",

	-- Marks & Session -----------------------------------------------------------
	{ "LintaoAmons/bookmarks.nvim", config = "plugins.bookmarks", tag = "v0.5.4" },
	{ "ThePrimeagen/harpoon", event = "VeryLazy", config = "plugins.harpoon" },
	{ "Shatur/neovim-session-manager", config = "plugins.session-manager", eager = true },
	{ "ahmedkhalf/project.nvim", config = "plugins.project" },
	{ "chentoast/marks.nvim", event = "VeryLazy", config = "plugins.marks" },

	-- Colorschemes --------------------------------------------------------------
	"dracula/vim",
	"folke/tokyonight.nvim",
	-- "Shatur/neovim-ayu",
	-- "NLKNguyen/papercolor-theme",
	-- "navarasu/onedark.nvim",
	-- additional colorschemes
	-- "marko-cerovac/material.nvim",
	-- "EdenEast/nightfox.nvim",
	-- "projekt0n/github-nvim-theme",
	-- "catppuccin/nvim",
	-- "wadackel/vim-dogrun",
	-- "rebelot/kanagawa.nvim",
	-- "Everblush/everblush.vim",
	-- "cocopon/iceberg.vim",
	-- "beardage/orlock.nvim",
	-- "rose-pine/neovim",

	-- Markdown ------------------------------------------------------------------
	{ "preservim/vim-markdown", config = "plugins.markdown" },
	{ "dkarter/bullets.vim", ft = "markdown", config = "plugins.bullets" },
	{ "iamcco/markdown-preview.nvim", build = "yarn", event = "VeryLazy", config = "plugins.markdown-preview" },
	{ "tenxsoydev/vim-markdown-checkswitch", ft = "markdown" },
	-- PKM / Zettelkasten
	-- { "obsidian-nvim/obsidian.nvim", config = "plugins.obsidian" },

	-- Utility -------------------------------------------------------------------
	{ "max397574/better-escape.nvim", event = "InsertEnter", config = "plugins.better-escape" },
	{ "nat-418/boole.nvim", event = "VeryLazy", config = "plugins.boole" }, -- extend increment / decrement to cycle through related words
	{ "famiu/bufdelete.nvim", lazy = true },
	{ "stevearc/dressing.nvim", event = "VeryLazy", config = "plugins.dressing" },
	{ "NMAC427/guess-indent.nvim", event = "VeryLazy", opts = {} },
	{ "smoka7/hop.nvim", event = "VeryLazy", config = "plugins.hop" },
	{ "kevinhwang91/nvim-hlslens", event = "VeryLazy", config = "plugins.hlslens" },
	{ "edluffy/hologram.nvim", event = "VeryLazy" },
	{ "lukas-reineke/indent-blankline.nvim", event = "VeryLazy", config = "plugins.indentline" },
	{ "echasnovski/mini.nvim", event = "VeryLazy", config = "plugins.mini" },
	{ "karb94/neoscroll.nvim", event = "VeryLazy", config = "plugins.neoscroll" },
	{ "nacro90/numb.nvim", event = "VeryLazy", opts = {} },
	{ "windwp/nvim-autopairs", event = "VeryLazy", config = "plugins.autopairs" },
	{ "NvChad/nvim-colorizer.lua", event = "VeryLazy", config = "plugins.colorizer" },
	{ "gennaro-tedesco/nvim-jqx", event = "VeryLazy", ft = "json" },
	{ "windwp/nvim-spectre", event = "VeryLazy", config = "plugins.spectre" },
	-- stylua: ignore
	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async", event = "VeryLazy", config = "plugins.ufo" },
	{ "nvim-tree/nvim-web-devicons", config = "plugins.devicons", eager = true },
	"nvim-lua/plenary.nvim",
	{ "tenxsoydev/size-matters.nvim", lazy = true },
	{ "michaelb/sniprun", event = "VeryLazy", build = "bash ./install.sh", config = "plugins.sniprun" },
	{ "luukvbaal/statuscol.nvim", config = "plugins.statuscol" },
	{ "levouh/tint.nvim", event = "VeryLazy", config = "plugins.tint" },
	{ "tenxsoydev/tabs-vs-spaces.nvim", event = "VeryLazy", config = "plugins.tabs-vs-spaces" },
	{ "andymass/vim-matchup", event = "VeryLazy", config = "plugins.matchup" }, -- highlight matching patterns and extend `%` navigation
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{ "tpope/vim-surround", event = "VeryLazy" },
	"mg979/vim-visual-multi", -- needs to be loaded outside of lazy.nvim for its global variable config values to work
	{
		"folke/which-key.nvim",
		lazy = true,
		config = "plugins.which-key",
		commit = "af4ded85542d40e190014c732fa051bdbf88be3d",
	},

	-- Stash ---------------------------------------------------------------------
	-- "tiagovla/scope.nvim", -- scope buffers to tabs
	-- "nvim-telescope/telescope-file-browser.nvim",
}

-- Problem childs that need to be loaded outside of `lazy.setup`
require("nxvim.plugins.visual-multi") -- resolves global variable settings (e.g. `vim.g.VM_map`) not working
-- ]

-- == [ Transform to LazySpec Table ===========================================

---Config load helper
---@param plugin_config string
---@param eager? boolean
local function get(plugin_config, eager)
	if (plugin_config:match("plugins") or plugin_config:match("colorschemes")) and not plugin_config:match("nxvim") then
		plugin_config = "nxvim." .. plugin_config
	end

	if eager then return function() require(plugin_config) end end

	return function()
		-- scheduled loading the majority of config files - results in 30-35% faster startup
		vim.schedule(function() require(plugin_config) end)
	end
end

for i, module in ipairs(modules) do
	if type(module) == "string" then goto continue end

	-- handle config string values (paths) else keep the module.config value
	if type(module.config) == "string" then
		if module[1]:sub(1, #"nxvim") == "nxvim" then module.config = "nxvim." .. module.config end
		---@diagnostic disable-next-line: param-type-mismatch
		module.config = get(module.config, module.eager)
	end

	-- remove custom fields
	if module.eager then module.eager = nil end

	::continue::
	modules[i] = module
end
-- ]

-- == [ Load Setup ============================================================

lazy.setup(modules, {
	ui = { border = "rounded" },
	dev = { path = "~/Dev/VIM/plugins/" },
})
--- ]

-- == [ Events ================================================================

nx.au({
	"BufEnter",
	pattern = { vim.fn.stdpath("config") .. "*/init.lua" },
	callback = function()
		-- Allow `gf` to the config file of a plugin in the module list above
		vim.opt_local.path = { ",,", vim.fn.stdpath("config") .. "/lua/nxvim/" }
		vim.cmd("setlocal inex=tr(v:fname,'.','/')")
	end,
})
-- ]

--- == [ Keymaps ===============================================================

nx.map({ "<leader>P", "<Cmd>Lazy<CR>", desc = "Plugin Manager" })
--- ]
