local M = {}

M.separator_style = { "", " " }
M.highlights = {}

-- == [ Backgrounds ===========================================================

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
	"error_diagnostic_selected",
	"indicator_selected",
	"indicator_visible",
	"info_selected",
	"info_visible",
	"info_diagnostic_visible",
	"info_diagnostic_selected",
	"warning_selected",
	"warning_visible",
	"warning_diagnostic_visible",
	"warning_diagnostic_selected",
	"modified_selected",
	"modified_visible",
	"numbers_selected",
	"numbers_visible",
	"pick_visible",
	"pick_selected",
	"separator_selected",
	"separator_visible",
	"tab_selected",
	"tab_close",
}

for _, key in ipairs(bg_solid) do
	local font = { italic = false, bold = false }

	if string.match(key, "diagnostic") then font.italic = false end

	M.highlights[key] = { bg = { attribute = "bg", highlight = "TabLine" }, bold = font.bold, italic = font.italic }
end

for _, key in ipairs(bg_transparent) do
	local font = { italic = true, bold = false }

	if string.match(key, "diagnostic") then font.italic = false end
	if string.match(key, "tab") or string.match(key, "close_button") then font.italic = false end

	M.highlights[key] = { bg = { attribute = "bg", highlight = "Normal" }, bold = font.bold, italic = font.italic }
end
-- ]

-- == [ Foreground ============================================================

for _, key in ipairs({ "warning_visible", "modified", "modified_visible" }) do
	M.highlights[key].fg = { attribute = "fg", highlight = "TabLine" }
end

for _, key in ipairs({ "tab_separator", "tab_separator_selected" }) do
	M.highlights[key].fg = { attribute = "bg", highlight = "TabLine" }
end

M.highlights.separator.fg = { attribute = "fg", highlight = "BufferlineSeparatorSelected" }
M.highlights.separator_selected.fg = { attribute = "fg", highlight = "BufferlineSeparatorSelected" }
M.highlights.modified_selected.fg = { attribute = "fg", highlight = "Normal" }
-- ]

-- == [ Shadow ================================================================

local function set_shadow() nx.hl({ "BufferlineSeparatorSelected", fg = "TabLine:bg:#b-10", bg = "Normal:bg" }) end

set_shadow()

nx.au({ "Colorscheme", callback = function() set_shadow() end })
-- ]

return M
