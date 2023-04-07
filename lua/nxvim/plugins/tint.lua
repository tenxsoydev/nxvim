-- https://github.com/levouh/tint.nvim

local tint = require("tint")

-- { == Configuration ==> =====================================================

local config = {
	tint = -30,
	highlight_ignore_patterns = {
		"WinSeparator",
		"IndentBlankline*",
		"NeoTreeTabInactive",
		"NeoTreeTabActive",
		"NeoTreeTabSeparatorActive",
		"NeoTreeTabSeparatorInactive",
		"ShortLineLeftWindowNumberSeparator",
		"ShortLineLeftBufferTypeSeparator",
		-- "NormalSB", -- not working with tokyonight therefore also using transparent
		-- "NeoTreeNormal",
	},
}
-- <== }

-- { == Highlights ==> ========================================================

if vim.g.colors_name == "tokyonight" then
	if require("tokyonight.config").options.style ~= "day" then
		-- brighten up LineNr a bit to fix problems with tint highlighting
		nx.hl({
			{ "LineNr", fg = "LineNr:fg:#b+10" },
			{ "Winbar", { link = "LineNr" } },
		})
		config.tint = -20
	else
		config.tint = 25
	end
end
-- <== }

tint.setup(config)

-- { == Events ==> ============================================================

nx.au({
	{ "Colorscheme", "SessionLoadPost" },
	callback = function() vim.defer_fn(tint.refresh, 250) end,
})
-- <== }

-- { == Commands ==> ============================================================

nx.cmd({ "TintRefresh", tint.refresh })

-- <== }
