-- https://github.com/Bekaboo/dropbar.nvim

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

nx.hl({ "DropBarIconUISeparator", link = "Winbar" })
-- ]
