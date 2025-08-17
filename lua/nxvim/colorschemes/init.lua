local default_colorscheme = "dracula"
-- Changing a colorscheme during a session can partially break highlights
-- to have an unimaired experience, define a theme of preference as default and restart vim

-- Load colorscheme setup BEFORE applying the colorscheme
pcall(require("nxvim.colorschemes." .. default_colorscheme))
-- Apply default colorscheme
vim.cmd("colorscheme " .. default_colorscheme)

-- == [ Highlights ============================================================

---Set kitty colorscheme based on neovim colorscheme
-- TODO: add further commenting about kitty theme files
---@param color_scheme string @kitty colorscheme file
local function set_kitty_colors(color_scheme)
	local socket = vim.fn.expand("$KITTY_LISTEN_ON")
	local color_scheme_path = "~/.config/kitty/themes/" .. color_scheme .. ".conf"
	if vim.fn.filereadable(vim.fn.expand(color_scheme_path)) == 0 then return end
	vim.fn.system("kitten @ --to " .. socket .. " set-colors " .. color_scheme_path)
	vim.cmd("redraw")
end

-- Cutomization - after applying colorscheme
local function set_hl()
	nx.hl({
		{ "Comment", fg = "Comment:fg", italic = true },
		{ { "Winbar", "FoldColumn" }, link = "LineNr" },
	})

	if vim.env.TERM == "xterm-kitty" then
		set_kitty_colors(vim.g.colors_name == "ayu" and "ayu_mirage" or vim.g.colors_name)
	end

	if vim.g.colors_name == "dracula" then
		require("nxvim.colorschemes.dracula").set_hl()
	elseif vim.g.colors_name == "tokyonight" then
		require("nxvim.colorschemes.tokyonight").set_hl()
	end
end

nx.au({ { "UIEnter", "Colorscheme" }, callback = set_hl })
-- ]
