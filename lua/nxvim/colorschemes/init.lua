local default_colorscheme = "dracula"
-- changing a colorscheme during a session can partially break highlights
-- to have an unimaired experience, define a theme of preference as default and restart vim

-- make sure to load colorscheme setup befor applying the scolorscheme
pcall(require("nxvim.colorschemes." .. default_colorscheme))

-- Apply default colorscheme
vim.cmd("colorscheme " .. default_colorscheme)

-- { == Highlights ==> ========================================================

-- Cutomization - after applying colorscheme
local function set_hl()
	nx.hl({
		-- Terminals like kitty or alacritty allow to specify different font families for font styles and variants.
		-- bold-italic is not used very often, so e.g. we set `Comment` hls to bold-italic and use FantasqueSans for them,
		-- while JetBrainsMono is used for the rest. Search for `"xterm-kitty"` to find more customizations
		-- { "Comment", fg = "Comment:fg", italic = true, bold = vim.env.TERM == "xterm-kitty" },

		{ { "Winbar", "FoldColumn" }, link = "LineNr" },
	})

	if vim.g.colors_name == "dracula" then
		require("nxvim.colorschemes.dracula").set_hl()
	elseif vim.g.colors_name == "tokyonight" then
		require("nxvim.colorschemes.tokyonight").set_hl()
	end

	require("nxvim.lsp.plugins.lspsaga").set_hl()
end

nx.au({ { "UIEnter", "Colorscheme" }, callback = set_hl })
-- <== }
