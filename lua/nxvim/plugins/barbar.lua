-- https://github.com/romgrk/barbar.nvim#--barbarnvim

-- { == Configuration ==> =====================================================

require("bufferline").setup({
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
		separator = { left = "▏", right = " " },
		modified = { button = "" },
		pinned = { button = "" },
		inactive = {
			-- separator = { left = "" },
			separator = { left = "▏" },
			button = "×",
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
	callback = function(ev)
		local bufwinid
		local set_offset = require("barbar.api").set_offset
		-- TODO: WinScrolled for below 0.9 also for other aus that have winres
		local au = vim.api.nvim_create_autocmd("WinResized", {
			callback = function()
				bufwinid = bufwinid or vim.fn.bufwinid(ev.buf)
				-- set_offset(vim.api.nvim_win_get_width(bufwinid), " 󰙅 Neo-tree")
				set_offset(
					vim.api.nvim_win_get_width(bufwinid),
					"󰙅 " .. require("nxvim.utils").truc_path(vim.fn.getcwd())
				)
			end,
		})
		nx.au({
			"BufWipeout",
			once = true,
			buffer = ev.buf,
			callback = function()
				vim.api.nvim_del_autocmd(au)
				set_offset(0)
			end,
		})
	end,
	pattern = "neo-tree",
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

nx.map(maps)
-- <== }

--- { == Highlights ==> =======================================================

nx.hl({
	{ "BufferCurrentMod", link = "BufferCurrent" },

	{ "BufferAlternate", fg = "#9dacb9", italic = true },
	-- TODO: Dyanmic theme color
	{ "BufferVisible", fg = "#9dacb9", bg = "none" },
	{ "BufferVisibleSign", fg = "TabLine:bg:#b-10", bg = "BufferVisible:bg" },
	{ "BufferVisibleIndex", link = "BufferVisible" },
	{ "BufferVisibleMod", link = "BufferVisible" },

	{ "BufferInactive", fg = "Comment:fg", bg = "TabLine:bg" },
	{ "BufferInactiveSign", fg = "TabLine:bg:#b-10", bg = "TabLine:bg" },
	{ "BufferInactiveIndex", link = "BufferInactive" },
	{ "BufferInactiveMod", link = "BufferInactive" },

	{ "BufferTabpages", link = "LineNr" },
	{ "BufferTabpageFill", fg = "TabLine:bg:#b-10", bg = "TabLine:bg" }, -- Used for "last-sign"
	{ "BufferOffset", fg = "Directory:fg", bg = "Tabline:bg" },
})
-- <== }

if vim.bo.ft == "alpha" then vim.o.showtabline = 0 end
