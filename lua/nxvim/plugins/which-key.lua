-- https://github.com/folke/which-key.nvim

local wk = require("which-key")

-- { == Configuration ==> =====================================================

wk.setup({
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<CR>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		-- separator = "",
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 0, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 1, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 5, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 4, -- spacing between columns
		align = "center", -- align columns left, center or right
	},
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<Cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = false, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		n = { ";", "y" },
		v = { "j", "k" },
		i = { "j", "k", "<lt>" },
	},
})

-- <== }

-- { == Key Label Customization ==> ============================================

-- Which-Key is configured to automatically set up triggers. The additional registration of labels is to
-- assign labels to groups and to modify or ignore the labels of keymaps gathered automatically.
wk.register({
	["/"] = { name = "Search" },
	[","] = { name = "Config" },
	["`"] = { name = "Terminal", ["`"] = "Toggle" },
	b = { name = "Buffers" },
	d = { name = "Diagnostics" },
	f = { name = "File" },
	g = {
		name = "Git",
		y = "Link",
		G = { name = "Gist" },
	},
	c = { name = "Todo-Comments" },
	h = { name = "History" },
	l = { name = "LSP" },
	m = { name = "Bookmarks" },
	r = { name = "Replace" },
	R = { name = "SnipRun" },
	s = { name = "Sessions" },
	t = { name = "Toggle", d = { name = "Diagnostics" } },
	T = { name = "Treesitter" },
}, { prefix = "<leader>" })

wk.register({
	d = "Delete fold at cursor",
	D = "Delete fold at cursor recursively",
	E = "Eliminate all folds in window",
	["%"] = "which_key_ignore", -- ignore matchup key label
}, { prefix = "z" })

wk.register({
	["/"] = { name = "Search Marks" },
	h = { name = "Harpoon" },
	x = { name = "Delete Marks" },
	["0"] = "which_key_ignore",
}, { prefix = "m" })

wk.register({
	["<C-/>"] = "which_key_ignore",
	["<C-_>"] = "which_key_ignore",
	j = "which_key_ignore",
	k = "which_key_ignore",
	g = "which_key_ignore",
	r = { name = "Replace" },
}, { prefix = "<leader>", mode = "v" })

wk.register({
	t = { name = "Tabs" },
}, { prefix = "<C-w>" })

wk.register({
	c = "which_key_ignore",
	b = "which_key_ignore",
}, { prefix = "g", mode = { "n", "v" } })
-- <== }
