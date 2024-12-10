-- https://github.com/nvim-tree/nvim-web-devicons

-- == [ Configuration =========================================================
local c3 = {
	icon = "󱤹",
	color = "#7986cb",
	cterm_color = "104",
	name = "C3",
}

require("nvim-web-devicons").setup({
	override_by_extension = {
		["c3"] = c3,
		["c3i"] = c3,
		["c3t"] = c3,
		["njk"] = {
			icon = "",
			color = "#e44d26",
			cterm_color = "196",
			name = "Nunjucks",
		},
		["odin"] = {
			icon = "󰗐",
			color = "#4285F4",
			cterm_color = "33",
			name = "Odin",
		},
		["onyx"] = {
			icon = "󰫆",
			color = "#6d8086",
			cterm_color = "66",
			name = "Onyx",
		},
		["onyx-pkg.kdl"] = {
			icon = "",
			color = "#41535b",
			cterm_color = "239",
			name = "Onyx",
		},
		["py"] = {
			icon = "",
			color = "#4B8BBE",
			cterm_color = "214",
			name = "Py",
		},
		["sp"] = {
			icon = "󱗆",
			color = "#4B8BBE",
			cterm_color = "214",
			name = "Spawn",
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
-- ]
