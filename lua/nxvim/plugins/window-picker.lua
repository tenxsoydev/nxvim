-- https://github.com/s1n7ax/nvim-window-picker

-- { == Configuration ==> =====================================================

require("window-picker").setup({
	autoselect_one = true,
	include_current = false,
	filter_rules = {
		-- filter using buffer options
		bo = {
			-- if the file type is one of following, the window will be ignored
			filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

			-- if the buffer type is one of following, the window will be ignored
			buftype = { "terminal" },
		},
	},
})

nx.hl({
	{ "NvimWindoSwitchNC", bg = "StatusLineNC:bg" },
	{ "NvimWindoSwitch", bg = "StatusLine:bg" },
})

-- <== }
