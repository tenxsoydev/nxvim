local ts_configs = require("nvim-treesitter.configs")

-- { == Configuration ==> =====================================================

local config = {
	-- parser_install_dir = "/home/turiiya/.local/share/nvim/lazy/nvim-treesitter/",
	ensure_installed = "lua", -- A list of parser names, or "all"
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	-- "comment" results in major performance issues when using block comments
	ignore_install = { "comment" }, -- List of parsers to ignore installing
	highlight = {
		-- use_languagetree = true,
		enable = true, -- false will disable the whole extension
		disable = { "css", "html", "help" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = false,
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "yaml", "python", "css" } },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	autotag = {
		enable = true,
		disable = { "xml" },
	},
	rainbow = {
		enable = true,
		colors = {
			"Gold",
			"Orchid",
			"DodgerBlue",
			-- "Cornsilk",
			-- "Salmon",
			-- "LawnGreen",
		},
		disable = { "html" },
	},
	playground = {
		enable = true,
	},
	matchup = {
		enable = true, -- mandatory, false will disable the whole extension
		-- disable = { "c", "ruby" }, -- optional, list of language that will be disabled
		-- [options]
	},
	incremental_selection = {
		enable = true,
		keymaps = {},
	},
}
-- <== }

-- { == Keymaps ==> ===========================================================

config.incremental_selection.keymaps = {
	init_selection = "<CR>",
	scope_incremental = "<C-CR>",
	node_incremental = "<CR>",
	node_decremental = "<BS>",
}

nx.map({
	{ "<leader>Th", "<Cmd>TSHighlightCapturesUnderCursor<CR>", desc = "Highlight" },
	{ "<leader>Tp", "<Cmd>TSPlaygroundToggle<CR>", desc = "Playground" },
	{
		"<F7>",
		"<Cmd>TSHighlightCapturesUnderCursor<CR>",
		desc = "Show TS Highlight Information for Element Under Cursor",
	},
	{ "<F8>", "<Cmd>TSPlaygroundToggle<CR>", desc = "Toggle Treesitter Playground" },
})
-- <== }

ts_configs.setup(config)
