-- https://github.com/folke/tokyonight.nvim

local tokyonight = require("tokyonight")

-- { == Configuration ==> =====================================================

local config = {
	-- style = "day", -- "storm"|"moon"|"night"|"day"
	transparent = false,
	styles = {
		sidebars = "transparent", -- NOTE: "dark" unfortunately does not work with tint atm
		floats = "transparent",
	},
}

if vim.g.nx_loaded_gui then config.transparent = false end

tokyonight.setup(config)
-- <== }

-- Highlights =================================================================

local M = {}

function M.set_hl()
	-- remove additional dark border around float borders (e.g. wilder command palette)
	nx.hl({
		{ "FloatBorder", fg = "FloatBorder:fg", bg = "none" },
		{ { "FloatShadow", "FloatShadowThrough" }, link = "Float" },
	})

	if require("tokyonight.config").options.style ~= "day" then
		nx.hl({
			{ "WinSeparator", fg = "WinSeparator:fg:#b-1" },
		})
	else
		nx.hl({
			{ "TabLine", link = "DiffChange" },
			{ "BufferLineOffset", { link = "TabLine" } },
		})
	end
end

return M
