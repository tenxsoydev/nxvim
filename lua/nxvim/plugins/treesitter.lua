local ts_configs = require("nvim-treesitter.configs")

-- { == Configuration ==> =====================================================

local config = {
	-- parser_install_dir = "~/.local/share/nvim/lazy/nvim-treesitter/",
	ensure_installed = "lua", -- A list of parser names, or "all"
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	-- "comment" results in major performance issues when using block comments
	-- in case TSUninstall is not working: "rm ~/.local/share/nvim/lazy/nvim-treesitter/parser/comment.so",
	ignore_install = { "comment" }, -- List of parsers to ignore installing
	highlight = {
		enable = true,
		disable = { "css", "html", "help", "json" },
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
	playground = {
		enable = true,
	},
	illuminate = {
		-- Helps with heavy performance bottlenecks in large files.
		-- This does not disable illuminate since it uses lsp as provider.
		enable = false,
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
	-- stylua: ignore
	{ "<F8>", "<Cmd>TSHighlightCapturesUnderCursor<CR>", desc = "Show TS Highlight Information for Element Under Cursor" },
	{ { "<S-F8>", "<F20>" }, "<Cmd>TSPlaygroundToggle<CR>", desc = "Toggle Treesitter Playground" },
})
-- <== }

ts_configs.setup(config)
