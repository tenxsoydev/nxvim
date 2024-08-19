local default_colorscheme = "dracula"
-- changing a colorscheme during a session can partially break highlights
-- to have an unimaired experience, define a theme of preference as default and restart vim

-- make sure to load colorscheme setup before applying the colorscheme
pcall(require("nxvim.colorschemes." .. default_colorscheme))

-- Apply default colorscheme
vim.cmd("colorscheme " .. default_colorscheme)

-- == [ Highlights ============================================================

---Set kitty colorscheme based on neovim colorscheme.
---@param colors string @kitty colorscheme file
local function kitty_colors(colors)
	if not vim.fn.executable("kitty") then return end
	local cmd = "kitty @ --to %s set-colors -a %s"
	local socket = vim.fn.expand("$KITTY_LISTEN_ON")
	vim.fn.system(cmd:format(socket, "~/.config/kitty/" .. colors .. ".conf"))
	vim.cmd("redraw")
end

-- Cutomization - after applying colorscheme
local function set_hl()
	nx.hl({
		{ "Comment", fg = "Comment:fg", italic = true, bold = nx.opts.second_font },
		{ { "Winbar", "FoldColumn" }, link = "LineNr" },
	})

	if vim.g.colors_name == "dracula" then
		kitty_colors("dracula")
		require("nxvim.colorschemes.dracula").set_hl()
	elseif vim.g.colors_name == "tokyonight" then
		kitty_colors("tokyonight_storm")
		require("nxvim.colorschemes.tokyonight").set_hl()
	end
end

nx.au({ { "UIEnter", "Colorscheme" }, callback = set_hl })
-- ]
