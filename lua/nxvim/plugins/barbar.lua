-- https://github.com/romgrk/barbar.nvim#--barbarnvim

-- == [ Configuration =========================================================

require("barbar").setup({
	animation = true,
	auto_hide = vim.env.KITTY_SCROLLBACK_NVIM == 'true' and 1 or -1,
	tabpages = true,
	closable = true,
	clickable = true,
	highlight_alternate = false,
	icons = {
		buffer_index = "superscript",
		-- buffer_number = "superscript",
		button = "×",
		filetype = { enabled = true },
		separator = { left = "▏", right = "" },
		modified = { button = "" },
		pinned = { button = "", filename = true },
		inactive = {
			-- use right = "" for "popout"-effect
			separator = { left = " ", right = "▕" },
			button = "×",
		},
		diagnostics = {
			[vim.diagnostic.severity.ERROR] = { enabled = true, icon = "" },
			[vim.diagnostic.severity.WARN] = { enabled = true, icon = "" },
			[vim.diagnostic.severity.INFO] = { enabled = false, icon = "" },
			[vim.diagnostic.severity.HINT] = { enabled = false, icon = "󰌶" },
		},
	},
	insert_at_end = false,
	insert_at_start = false,
	maximum_padding = 1,
	minimum_padding = 1,
	maximum_length = 30,
	semantic_letters = true,
	letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
	no_name_title = nil,
})
-- ]

-- == [ Keymaps ===============================================================

local maps = {
	{ "<S-l>", "<Cmd>BufferNext<CR>", desc = "Go to Next Buffer" },
	{ "<S-h>", "<Cmd>BufferPrevious<CR>", desc = "Go to Previous Buffer" },
	{ vim.g.eu_kbd and "ø" or "<A-l>", "<Cmd>BufferMoveNext<CR>", desc = "Move Buffer Right" },
	{ vim.g.eu_kbd and "ù" or "<A-h>", "<Cmd>BufferMovePrevious<CR>", desc = "Move Buffer Left" },
	-- TODO: osx map
	{ "<A-C-p>", "<Cmd>BufferPin<CR>" },
	{ "<leader>bp", "<Cmd>BufferPin<CR>" },
	-- { "<A-c>", "<Cmd>BufferClose<CR>" },
	{ "<leader>bc", "<Cmd>BufferClose!<CR>", desc = "Close! Buffer" },
	{ "<leader>bC", "<Cmd>BufferCloseAllButCurrent<CR>", desc = "Close All Others" },
	{ "<leader>bl", "<Cmd>BufferCloseBuffersRight<CR>", desc = "Close All to the Right" },
	{ "<leader>bh", "<Cmd>BufferCloseBuffersLeft<CR>", desc = "Close All to the Left" },
	{ "<leader>bf", "<Cmd>BufferPick<CR>", desc = "Pick Buffer to Focus" },
	{ "<leader>bx", "<Cmd>BufferPickDelete<CR>", desc = "Pick Buffer to Close" },
	{ "<leader>bD", "<Cmd>BufferOrderByDirectory<CR>", desc = "Sort by Directory" },
	{ "<leader>bL", "<Cmd>BufferOrderByLanguage<CR>", desc = "Sort by Language" },
	-- { "<leader>bW", "<Cmd>BufferOrderByWindowNumber<CR>", desc = "Sort by Window Number" },
	-- { "<leader>bN", "<Cmd>BufferOrderByBufferNumber<CR>", desc = "Sort by Buffer Number" },},
}

for i = 0, 9 do
	local lhs = "<leader>" .. i
	local bufnr = i
	local desc = "Go to Buffer #" .. i

	if i == 0 then
		lhs = "<leader>$"
		bufnr = -1
		desc = "Go to Last Buffer"
	end

	local rhs = ":BufferGoto " .. bufnr .. "<CR>"
	table.insert(maps, { lhs, rhs, desc = desc, wk_label = "ignore" })
end

nx.map(maps, { silent = true })
-- ]

--- == [ Highlights ===========================================================

nx.hl({
	{ "BufferCurrent", fg = "BufferCurrent:fg" },
	{ "BufferCurrentMod", link = "BufferCurrent" },
	{ "BufferCurrentIndex", fg = "BufferCurrentIndex:fg" },
	{ "BufferCurrentNumber", fg = "BufferCurrentNumber:fg" },
	{ "BufferCurrentSign", fg = "BufferCurrentSign:fg" },
	{ "BufferCurrentSignRight", fg = "TabLine:bg:#b-10", bg = "Tabline:bg" },
	{ "BufferCurrentERROR", fg = "DiagnosticSignError:fg" },
	{ "BufferCurrentWARN", fg = "DiagnosticSignWarn:fg" },
	{ "BufferCurrentHINT", fg = "DiagnosticSignHint:fg" },
	{ "BufferCurrentINFO", fg = "DiagnosticSignInfo:fg" },

	-- TODO: Dyanmic theme colors instead of hex
	{ "BufferAlternate", fg = "#9dacb9", italic = true },

	{ { "BufferVisible", "TabLineFill" }, fg = "#9dacb9", bg = "none" },
	{ "BufferVisibleSign", fg = "TabLine:bg", bg = "BufferVisible:bg" },

	{ "BufferInactive", fg = "Comment:fg", bg = "TabLine:bg" },
	{
		{ "BufferInactiveSign", "BufferInactiveSignRight", "BufferVisibleSignRight" },
		fg = "TabLine:bg:#b-10",
		bg = "TabLine:bg",
	},

	{ { "BufferTabpages", "BufferDefaultTabpagesSep", "BufferScrollArrow" }, link = "LineNr" },
	{ "BufferTabpageFill", fg = "TabLine:bg:#b-10", bg = "TabLine:bg" }, -- Used for "last-sign"
	{ "BufferOffset", fg = "Directory:fg", bg = "Tabline:bg" },
})

nx.hl({
	{ "BufferAlternateERROR" },
	{ "BufferAlternateWARN" },
	{ "BufferAlternateHINT" },
	{ "BufferAlternateINFO" },
}, { link = "BufferAlternate" })
nx.hl({
	{ "BufferVisibleIndex" },
	{ "BufferVisibleMod" },
	{ "BufferVisibleERROR" },
	{ "BufferVisibleWARN" },
	{ "BufferVisibleHINT" },
	{ "BufferVisibleINFO" },
}, { link = "BufferVisible" })
nx.hl({
	{ "BufferInactiveIndex" },
	{ "BufferInactiveMod" },
	{ "BufferInactiveERROR" },
	{ "BufferInactiveWARN" },
	{ "BufferInactiveHINT" },
	{ "BufferInactiveINFO" },
}, { link = "BufferInactive" })
-- ]

-- Hide tabline when barbar is loaded after opening a neovim client on a dashboard
if vim.bo.filetype == "alpha" then vim.o.showtabline = 0 end
