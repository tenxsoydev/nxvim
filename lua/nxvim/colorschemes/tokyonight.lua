-- https://github.com/folke/tokyonight.nvim

-- == [ Configuration =========================================================

require("tokyonight").setup({
	-- style = "day", -- "storm"|"moon"|"night"|"day"
	transparent = nx.opts.transparency and not vim.g.loaded_gui or false,
	styles = {
		sidebars = "transparent", -- NOTE: "dark" unfortunately does not work with tint atm
		floats = "transparent",
	},
})
-- ]

-- Highlights =================================================================

local M = {}

function M.set_hl()
	-- remove additional dark border around float borders (e.g. wilder command palette)
	nx.hl({
		{ "FloatBorder", fg = "FloatBorder:fg" },
		{ "CursorLine", bg = "CursorLine:bg:#b+15" },
		{ { "FloatShadow", "FloatShadowThrough" }, link = "Float" },
	})

	if require("tokyonight.config").options.style ~= "day" then
		nx.hl({
			{ "WinSeparator", fg = "WinSeparator:fg:#b-1" },
		})
	else
		nx.hl({
			{ "TabLine", link = "DiffChange" },
			{ "BufferLineOffset", link = "TabLine" },
		})
	end
end
-- ]

return M
