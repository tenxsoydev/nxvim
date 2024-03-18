-- https://github.com/nvim-tree/nvim-web-devicons

-- { == Configuration ==> =====================================================

require("nvim-web-devicons").setup({
	override_by_extension = {
		["njk"] = {
			icon = "",
			color = "#e44d26",
			cterm_color = "196",
			name = "Nunjucks",
		},
		["py"] = {
			icon = "",
			color = "#4B8BBE",
			cterm_color = "214",
			name = "Py",
		},
		["v"] = {
			icon = "",
			color = "#5D87BF",
			cterm_color = "24",
			name = "Vlang",
		},
		["vv"] = {
			icon = "",
			color = "#41535b",
			cterm_color = "239",
			name = "VlangTestFile",
		},
		["vb"] = {
			icon = "󰈜",
			color = "#1D6F42",
			cterm_color = "29",
			name = "VBA",
		},
		["vto"] = {
			icon = "",
			color = "#7ebae4",
			cterm_color = "110",
			name = "Vento",
		},
	},
})
-- <== }
