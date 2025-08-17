local M = {}

---@class NxOpts
---@field float_win_border "single"|"rounded"|"double"|"none" @border style for float windows and cmp popups
---@field transparency boolean
-- Most modern terminal configs allow specifying different fonts for weight and style variants.
-- For example, we can utilize bold-italic to display a second font (TODO: link to e.g./docs https://...).
---@field second_font boolean
nx.opts = {
	float_win_border = "rounded",
	transparency = true,
	second_font = false,
}

-- MacOS
if jit.os == "OSX" then
	vim.g.osx = true
	if vim.env.TERM_PROGRAM ~= "WezTerm" then
		vim.g.eu_kbd = vim.fn
			.system(
				"defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep -w \"KeyboardLayout Name\" | awk '{print $4}' | tr -d ';\"'"
			)
			:gsub("%s+", "") == "EurKEY"
	end
end

return M
