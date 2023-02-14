local windline = require("windline")
local style_nxvim = require("nxvim.plugins.windline.styles.nxvim")

-- { == Configuration ==> =====================================================

local config = {
	statuslines = {
		style_nxvim.default,
		style_nxvim.quickfix,
		style_nxvim.explorer,
		style_nxvim.dashboard,
		style_nxvim.terminal,
		style_nxvim.diffview,
	},
}
-- <== }

-- { == Highlights ==> =====================================================

config.colors_name = function(colors)
	local inactive_fg, inactive_bg, filename_fg, statusline_path
	if vim.g.colors_name == "dracula" then
		local get_hl = require("nxvim.utils").get_hl
		nx.hl({ "StatusLine", bg = "TabLine:bg" })

		inactive_fg = require("windline.themes").get_hl_color("SignColumn")
		inactive_bg = get_hl("TabLine", "bg")
		filename_fg = require("nxvim.colorschemes.dracula").palette.light_grey
		statusline_path = require("nxvim.colorschemes.dracula").palette.light_grey - 197122 * 10
	end

	if vim.g.colors_name:match("tokyonight") then
		filename_fg = require("windline.themes").get_hl_color("StatusLine")
	end

	--- add new colors
	-- colors.FilenameFg = colors.white_light
	-- colors.FilenameBg = colors.black

	-- this color will not update if you change a colorscheme
	-- colors.gray = "#fefefe"

	-- dynamically get color from colorscheme hightlight group
	local searchFg, searchBg = require("windline.themes").get_hl_color("Search")
	colors.SearchFg = searchFg or colors.white
	colors.SearchBg = searchBg or colors.yellow
	colors.InactiveFg = inactive_fg or colors.InactiveFg
	colors.InactiveBg = inactive_bg or colors.InactiveBg

	colors.FilenameFg = filename_fg or colors.white_light
	colors.StatusLinePath = statusline_path or colors.white_light

	return colors
end
-- <== }

windline.setup(config)
