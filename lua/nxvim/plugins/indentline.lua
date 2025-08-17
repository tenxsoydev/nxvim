-- https://github.com/lukas-reineke/indent-blankline.nvim

local ibl = require("ibl")
local hooks = require("ibl.hooks")

-- == [ Configuration =========================================================

-- "▏" "│" "▎" "⎸"" "¦" "┆" "" "┊" ""
local indent_char = "▏"

local config = {
	indent = { char = indent_char },
	scope = {},
}
-- ]

-- == [ Highlights ============================================================

config.scope.highlight = {
	"IndentLvlOne",
	"IndentLvlTwo",
	"IndentLvlThree",
	"IndentLvlFour",
	"IndentLvlFive",
	"IndentLvlSix",
}

hooks.register(
	hooks.type.HIGHLIGHT_SETUP,
	function()
		nx.hl({
			{ "IndentLvlOne", fg = "LineNr:fg" },
			{ "IndentLvlTwo", fg = "@attribute:fg" },
			{ "IndentLvlThree", fg = "@character:fg" },
			{ "IndentLvlFour", fg = "@constructor:fg" },
			{ "IndentLvlFive", fg = "@annotation:fg" },
			{ "IndentLvlSix", fg = "@label:fg" },
		})
	end
)
hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
-- ]

-- == [ Load Setup ===========================================================

ibl.setup(config)
-- ]
