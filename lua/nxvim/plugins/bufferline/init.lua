-- https://github.com/akinsho/bufferline.nvim

local bufferline = require("bufferline")

-- == [ Configuration =========================================================

local style = require("nxvim.plugins.bufferline.styles.slim-shady") -- slim-shady | slant
local bd = require("bufdelete")

bufferline.setup({
	options = {
		-- offsets = { { filetype = "NvimTree", text = " Explorer", text_align = "left", highlight = "Directory", padding = 1 } }, >
		offsets = {
			{
				-- text = "󰙅 Neo-tree",
				text = function() return "󰙅 " .. require("nxvim.utils").truc_path(vim.fn.getcwd()) end,
				filetype = "neo-tree",
				highlight = "BufferlineOffset",
				text_align = "left",
			},
		},
		indicator = {
			icon = vim.g.loaded_gui and "▏" or "▎",
			style = "icon",
		},
		numbers = function(opts) return string.format("%s", opts.raise(opts.ordinal)) end,
		buffer_close_icon = "×", -- "",
		modified_icon = "", -- "●",
		close_icon = "󰅖",
		close_command = function(bufnr) bd.bufdelete(bufnr, true) end,
		left_trunc_marker = "󰁍", -- "",
		right_trunc_marker = "󰁔", -- "",
		max_name_length = 16,
		max_prefix_length = 10,
		tab_size = 14,
		diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
		diagnostics_update_in_insert = false,
		---@diagnostic disable-next-line: unused-local
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local s = ""
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and "" or e == "warning" and "" or e == "info" and "" or "󰌶"
				s = s .. sym .. n
			end
			return s
		end,
		enforce_regular_tabs = false,
		show_tab_indicators = true,
		show_buffer_close_icons = true,
		separator_style = style.separator_style,
		always_show_bufferline = true,
		groups = {
			items = {
				require("bufferline.groups").builtin.pinned:with({ icon = "" }),
			},
		},
		-- hover = { enabled = true, delay = 150, reveal = { 'close' } },
	},
	highlights = style.highlights,
})
-- ]

-- == [ Keymaps ===============================================================

local maps = {
	{ "L", "<Cmd>BufferLineCycleNext<CR>", desc = "Go to Next Buffer" },
	{ "H", "<Cmd>BufferLineCyclePrev<CR>", desc = "Go to Previous Buffer" },
	{ "<A-l>", "<Cmd>BufferLineMoveNext<CR>", desc = "Move Buffer Right" },
	{ "<A-h>", "<Cmd>BufferLineMovePrev<CR>", desc = "Move Buffer Left" },
	{ "<leader>bp", "<Cmd>BufferLinePick<CR>", desc = "Pick Buffer to Focus" },
	{ "<leader>bP", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin " },
	{ "<A-C-p>", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin " },
	{ "<leader>bc", bd.bufdelete, desc = "Close! Buffer" },
	{ "<leader>bx", "<Cmd>BufferLinePickClose<CR>", desc = "Pick Buffer to Close" },
	{ "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", desc = "Close All to the Left" },
	{ "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", desc = "Close All to the Right" },
	{ "<leader>bL", "<Cmd>BufferLineSortByExtension<CR>", desc = "Sort by Language" },
	{ "<leader>bD", "<Cmd>BufferLineSortByDirectory<CR>", desc = "Sort by Directory" },
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

	local rhs = function() bufferline.go_to(bufnr, true) end

	table.insert(maps, {
		lhs,
		rhs,
		desc = desc,
		wk_label = "ignore",
	})
end

nx.map(maps)
-- ]

-- == [ Highlights ============================================================

if vim.g.colors_name == "dracula" then
	local palette = require("nxvim.colorschemes.dracula").palette
	nx.hl({
		{ { "BufferLineTab", "TabLineFill" }, link = "Normal" },
		{ "BufferLineIndicatorSelected", link = "DraculaPurple" },
		{ "BufferlineOffset", fg = palette.purple, bg = palette.bgdark },
	})
else
	nx.hl({ "BufferlineOffset", fg = "Directory:fg", bg = "Tabline:bg" })
end
-- ]

-- Hide tabline when bufferline is loaded after opening client on alpha
if vim.bo.filetype == "alpha" then vim.o.showtabline = 0 end
-- If opening nvim on a directory go to first buffer which will include tree-plugin
if vim.bo.filetype == "netrw" then vim.defer_fn(function() bufferline.go_to(1, true) end, 350) end
