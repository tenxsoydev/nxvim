-- https://github.com/stevearc/dressing.nvim

-- { == Configuration ==> =====================================================

require("dressing").setup({
	input = {
		win_options = {
			winblend = vim.o.winblend,
		},
	},
	select = {
		telescope = require("telescope.themes").get_dropdown({
			previewer = false,
			border = nx.opts.float_win_border ~= "none" and true or false,
		}),
		builtin = {
			win_options = {
				winblend = vim.o.winblend,
			},
			border = nx.opts.float_win_border,
		},
		nui = {
			win_options = {
				winblend = vim.o.winblend,
			},
			border = nx.opts.float_win_border,
		},
	},
})
-- <== }

-- { == Highlights ==> ========================================================

nx.map({
	{ "<Esc>", "<Esc>", "i" },
	{ "<C-c>", "<Cmd>close<CR>", { "i", "x" } },
	{ "q", "<Cmd>close<CR>", "x" },
}, { buffer = 0, ft = "DressingInput" })
-- <== }
