-- https://github.com/dracula/vim

-- { == Configuration ==> =====================================================

nx.set({
	dracula_italic = 1,
	dracula_bold = 1,
	dracula_full_special_attrs_support = 1,
	-- Don't use TUI transparency(causing black background) in GUIs
	dracula_colorterm = nx.opts.transparency and not vim.g.loaded_gui and 0 or 1,
})
-- <== }

-- { == Highlights ==> ========================================================

local M = {}

M.palette = {
	-- Default dracula palette
	-- ~/.local/share/nvim/site/pack/packer/start/vim/autoload/dracula.vim
	fg = "#F8F8F2",
	bglighter = "#424450",
	bglight = "#343746",
	bg = "#282A36",
	bgdark = "#21222C",
	bgdarker = "#191A21",
	comment = "#6272A4",
	selection = "#44475A",
	subtle = "#424450",
	cyan = "#8BE9FD",
	green = "#50FA7B",
	orange = "#FFB86C",
	pink = "#FF79C6",
	purple = "#BD93F9",
	red = "#FF5555",
	yellow = "#F1FA8C",
	-- Custom colors
	-- TODO:
	-- light_grey = "#9dacb9",
	light_grey = 10333369,
	tree_file_name = "#b8c5d1",
}

-- The official dracula themes highlighting partially doesn't behave as desired.
-- Anyway, we'll use the original repo instead of a fork, as it is likely more future-proof.
-- To make the theme super snazzy we do some improvements to the highlights below.
function M.set_hl()
	-- Client related highlights
	if vim.g.loaded_gui then
		nx.hl({
			{ "DraculaWinSeparator", fg = M.palette.bgdark },
		})
	else
		nx.hl({ "DraculaWinSeparator", fg = M.palette.bgdarker })
	end

	nx.hl({
		{ "NormalFloat", link = "Normal" },
		{ "DraculaLightGrey", fg = M.palette.light_grey },
		-- fix bluish dirs + don't use bold
		{ { "Directory", "MarkSignHl" }, link = "DraculaPurple" },

		-- Borders
		{ "FloatBorder", link = "SignColumn" },
		{ { "LspFloatWinBorder", "LspInfoBorder", "TelescopeBorder" }, link = "FloatBorder" },

		-- Diff text
		-- remove bg for diffdelte indicator in SignColumn
		{ "DraculaDiffDelete", fg = "DraculaDiffDelete:fg" },

		-- LSP
		{ "LspReferenceText", link = "StatusLineTermNC" },
		{ { "LspReferenceWrite", "LspReferenceRead" }, link = "LspReferenceText" },

		-- vim will fill the StatusLine with carets `^` if it has the same color as StatusLineNC
		{ "StatusLineNC", bg = "StatusLine:bg:#b-1" },
		{ "Winbar", link = "LineNr" },
	})
end

return M
