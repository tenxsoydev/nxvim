local M = {}

---@class NxOpts
---@field float_win_border "single"|"rounded"|"double"|"none" @border style for float windows and cmp popups
---@field transparency boolean
nx.opts = {
	float_win_border = "rounded",
	transparency = true,
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
