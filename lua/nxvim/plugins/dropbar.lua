-- https://github.com/Bekaboo/dropbar.nvim

local toggleterm = require("toggleterm")

-- == [ Configuration ========================================================

require("dropbar").setup({

	icons = {
		ui = {
			bar = {
				separator = "  ",
			},
		},
	},
})
-- ]

-- == [ Highlights ============================================================

nx.hl({
	{ "DropBarIconUISeparator", link = "Winbar" },
})
-- ]
