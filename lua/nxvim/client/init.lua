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
for _, client in ipairs({ "gnvim", "goneovim", "neovide", "nvui", "fvim_loaded" }) do
	if vim.g[client] then vim.g.loaded_gui = client end
end

local function init_gui()
	-- General GUI options
	local opt = vim.opt
	opt.fillchars:append("vert:│")
	opt.guifont = vim.g.osx and "Maple Mono NF:h14" or "Maple Mono NF:h12.5"
	opt.guicursor =
		"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait600-blinkoff800-blinkon900-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
	-- linespace = vim.g.osx and 3 or 2
	opt.linespace = 4
	opt.winblend = 10
	opt.pumblend = 10

	nx.opts.second_font = false

	-- GUI Plugins
	require("nxvim.plugins.size-matters")
end

function M.load_opts()
	if not vim.g.loaded_gui then return end
	init_gui()
	require("nxvim.client." .. vim.g.loaded_gui)
end

return M
