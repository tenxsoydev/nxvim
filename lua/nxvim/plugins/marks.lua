--https://github.com/chentoast/marks.nvim

-- { == Configuration ==> ====================================================

local config = {
	-- whether to map keybinds or not. default true
	default_mappings = false,
	-- which builtin marks to show. default {}
	-- builtin_marks = { "<", ">", "^" }, -- remove "." as it has to many interferes
	-- whether movements cycle back to the beginning/end of buffer. default true
	cyclic = true,
	-- whether the shada file is updated after modifying uppercase marks. default false
	force_write_shada = true,
	-- how often (in ms) to redraw signs/recompute mark positions.
	-- higher values will have better performance but may cause visual lag,
	-- while lower values may cause performance penalties. default 150.
	refresh_interval = 150,
	-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
	-- marks, and bookmarks.
	-- can be either a table with all/none of the keys, or a single number, in which case
	-- the priority applies to all marks.
	-- default 10.
	sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
	-- disables mark tracking for specific filetypes. default {}
	excluded_filetypes = { -- neccecary when using builtin marks - prior disabling "."
		"",
		"filetree",
		"toggleterm",
		"Outline",
		"NeogitCommitMessage",
		"NvimTree",
		"neo-tree-popup",
		"registers",
		"whichkey",
		"sagarename",
		"sagacodeaction",
		"lspsagafinder",
		-- probably deprecated
		"LspsagaDiagnostic",
		"LspsagaDefinition",
		"LspsagaImplement",
		"LspsagaFloaterm",
		"LspsagaHover",
		"LspsagaSignatureHelp",
	},
	-- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
	-- sign/virttext. Bookmarks can be used to group together positions and quickly move
	-- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
	-- default virt_text is "".
	bookmark_0 = {
		sign = "⚑",
		-- virt_text = "hello world"
	},
	mappings = {},
}
-- <== }

-- { == Keymaps ==> ===========================================================

config.mappings = {
	-- set_next = "m,",
	-- next = "m[",
	-- prev = "m]",
	-- preview = "mf",
	set_bookmark0 = "m0",
}

nx.map({
	{ "dml", "<Plug>(Marks-deleteline)", desc = "Delete Marks in Line" },
	{ "dmb", "<Plug>(Marks-deletebuf)", desc = "Delete Marks in Buffer" },
	{ "m/a", "<Cmd>MarksListAll<CR>", desc = "Search All Marks", wk_label = "All" },
	{ "m/b", "<Cmd>MarksListBuf<CR>", desc = "Search Marks in Buffer", wk_label = "Buffer" },
	{ "m/g", "<Cmd>MarksListGlobal<CR>", desc = "Search Global Marks", wk_label = "Global" },
	{ "m[", "<Plug>(Marks-next)", desc = "Move to Next Mark", wk_label = "Next Mark" },
	{ "m]", "<Plug>(Marks-prev)", desc = "Move to Previous Mark", wk_label = "Previous Mark" },
	{ "mt", "<Cmd>MarksToggleSigns<CR>", desc = "Toggle Marks Signs", wk_label = "Toggle Signs" },
	{ "mxl", "<Plug>(Marks-deleteline)", desc = "Delete Marks in Line", wk_label = "Line" },
	{ "mxb", "<Plug>(Marks-deletebuf)", desc = "Delete Marks in Buffer", wk_label = "Buffer" },
})
-- <== }

require("marks").setup(config)
