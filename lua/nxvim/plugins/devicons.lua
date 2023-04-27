-- https://github.com/nvim-tree/nvim-web-devicons

-- { == Configuration ==> =====================================================

require("nvim-web-devicons").setup({
	override_by_extension = {
		["v"] = {
			icon = "𝗩",
			color = "#5D87BF",
			cterm_color = "24",
			name = "V",
		},
		["py"] = {
			icon = "",
			color = "#4B8BBE",
			cterm_color = "214",
			name = "Py",
		},
	},
})
-- <== }
