local M = {}

M.separator_style = "slant"
M.highlights = {}

-- { == Backgrounds ==> =======================================================

-- *_diagnostic M.highlights icon without the buffer name
local bg_solid = {
	"fill",
	"background",
	"close_button",
	"diagnostic",
	"hint",
	"hint_diagnostic",
	"duplicate",
	"error",
	"error_diagnostic",
	"info",
	"info_diagnostic",
	"warning",
	"warning_diagnostic",
	"modified",
	"numbers",
	"pick",
	"separator",
	"tab",
	"tab_selected",
	"tab_separator",
	"tab_separator_selected",
}

local bg_transparent = {
	"buffer_selected",
	"buffer_visible",
	"close_button_visible",
	"diagnostic_selected",
	"diagnostic_visible",
	"hint_selected",
	"hint_visible",
	"hint_diagnostic_visible",
	"duplicate_selected",
	"duplicate_visible",
	"error_selected",
	"error_visible",
	"error_diagnostic_visible",
	"indicator_selected",
	"indicator_visible",
	"info_selected",
	"info_visible",
	"info_diagnostic_visible",
	"warning_selected",
	"warning_visible",
	"warning_diagnostic_visible",
	"modified_selected",
	"modified_visible",
	"numbers_selected",
	"numbers_visible",
	"pick_visible",
	"pick_selected",
	"separator_selected",
	"separator_visible",
}

for _, key in ipairs(bg_solid) do
	M.highlights[key] = { bg = { attribute = "bg", highlight = "TabLine" } }

	if string.match(key, "separator") then M.highlights[key].fg = { attribute = "bg", highlight = "TabLine" } end
end

for _, key in ipairs(bg_transparent) do
	local font = { italic = true, bold = false }
	if string.match(key, "tab") then font = { italic = false, bold = false } end

	M.highlights[key] = {
		bg = { attribute = "bg", highlight = "Normal" },
		bold = font.bold,
		italic = font.italic,
	}
	if string.match(key, "separator") then M.highlights[key].fg = { attribute = "bg", highlight = "TabLine" } end
end
-- <== }

-- { == Foreground ==> ========================================================

local fg_dimmed = {
	"warning_visible",
	"modified",
	"modified_visible",
}

for _, key in ipairs(fg_dimmed) do
	M.highlights[key].fg = { attribute = "fg", highlight = "TabLine" }
end

M.highlights.modified_selected.fg = { attribute = "fg", highlight = "Normal" }
-- <== }

return M
