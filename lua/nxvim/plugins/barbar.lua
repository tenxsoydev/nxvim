-- https://github.com/romgrk/barbar.nvim#--barbarnvim

-- { == Configuration ==> =====================================================

require("barbar").setup({
	animation = true,
	auto_hide = false,
	tabpages = true,
	closable = true,
	clickable = true,
	highlight_alternate = false,
	icons = {
		buffer_index = "superscript",
		-- buffer_number = "superscript",
		button = "×",
		filetype = { enabled = true },
		separator = { left = "▏", right = "" },
		modified = { button = "" },
		pinned = { button = "" },
		inactive = {
			-- separator = { left = "" },
			separator = { left = "▏" },
			button = "×",
		},
		diagnostics = {
			[vim.diagnostic.severity.ERROR] = { enabled = true, icon = "" },
			[vim.diagnostic.severity.WARN] = { enabled = true, icon = "" },
			[vim.diagnostic.severity.HINT] = { enabled = false, icon = "" },
			[vim.diagnostic.severity.INFO] = { enabled = false, icon = "" },
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
-- <== }

-- { == Events ==> ============================================================

nx.au({
	"FileType",
	pattern = "NeogitStatus",
	callback = function()
		vim.schedule(function() require("barbar.api").set_offset(0) end)
	end,
})
-- <== }

-- { == Keymaps ==> ===========================================================

local maps = {
	{ "<S-l>", ":BufferNext<CR>", desc = "Go to Next Buffer" },
	{ "<S-h>", ":BufferPrevious<CR>", desc = "Go to Previous Buffer" },
	{ "<A-l>", " :BufferMoveNext<CR>", desc = "Move Buffer Right" },
	{ "<A-h>", ":BufferMovePrevious<CR>", desc = "Move Buffer Left" },
	{ "<A-p>", ":BufferPin<CR>" },
	{ "<A-c>", ":BufferClose<CR>" },
	{ "<leader>bc", ":BufferClose!<CR>", desc = "Close! Buffer" },
	{ "<leader>bC", ":BufferCloseAllButCurrent<CR>", desc = "Close All Others" },
	{ "<leader>bl", ":BufferCloseBuffersRight<CR>", desc = "Close All to the Right" },
	{ "<leader>bh", ":BufferCloseBuffersLeft<CR>", desc = "Close All to the Left" },
	{ "<leader>bp", ":BufferPick<CR>", desc = "Pick Buffer to Focus" },
	{ "<leader>bP", ":BufferPickDelete<CR>", desc = "Pick Buffer to Focus" },
	{ "<leader>bD", ":BufferOrderByDirectory<CR>", desc = "Sort by Directory" },
	{ "<leader>bL", ":BufferOrderByLanguage<CR>", desc = "Sort by Language" },
	-- { "<leader>bW", ":BufferOrderByWindowNumber<CR>", desc = "Sort by Window Number" },
	-- { "<leader>bN", ":BufferOrderByBufferNumber<CR>", desc = "Sort by Buffer Number" },},
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
-- <== }

--- { == Highlights ==> =======================================================

nx.hl({
	{ "BufferCurrent", fg = "BufferCurrent:fg" },
	{ "BufferCurrentMod", link = "BufferCurrent" },
	{ "BufferCurrentIndex", fg = "BufferCurrentIndex:fg" },
	{ "BufferCurrentNumber", fg = "BufferCurrentNumber:fg" },
	{ "BufferCurrentSign", fg = "BufferCurrentSign:fg" },
	{ "BufferCurrentERROR", fg = "DiagnosticSignError:fg" },
	{ "BufferCurrentWARN", fg = "DiagnosticSignWarn:fg" },
	{ "BufferCurrentHINT", fg = "DiagnosticSignHint:fg" },
	{ "BufferCurrentINFO", fg = "DiagnosticSignInfo:fg" },

	-- TODO: Dyanmic theme colors instead of hex
	{ "BufferAlternate", fg = "#9dacb9", italic = true },

	{ "BufferVisible", fg = "#9dacb9", bg = "none" },
	{ "BufferVisibleSign", fg = "TabLine:bg:#b-10", bg = "BufferVisible:bg" },

	{ "BufferInactive", fg = "Comment:fg", bg = "TabLine:bg" },
	{ "BufferInactiveSign", fg = "TabLine:bg:#b-10", bg = "TabLine:bg" },

	{ "BufferTabpages", link = "LineNr" },
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
-- <== }

-- Hide tabline when barbar is loaded after opening a neovim client on a dashboard
if vim.bo.filetype == "alpha" then vim.o.showtabline = 0 end
-- If opening nvim on a directory go to first buffer, which will include tree-plugin
if vim.bo.filetype == "netrw" then vim.defer_fn(function() vim.cmd("BufferGoto 1") end, 100) end
