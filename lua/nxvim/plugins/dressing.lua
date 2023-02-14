-- https://github.com/stevearc/dressing.nvim

require("dressing").setup({
	input = {
		win_options = {
			winblend = vim.o.winblend,
		},
	},
})

-- { == Highlights ==> ========================================================

nx.map({
	{ "<Esc>", "<Esc>", "i" },
	{ "<C-c>", "<Cmd>close<CR>", { "i", "x" } },
	{ "q", "<Cmd>close<CR>", "x" },
}, { buffer = 0, ft = "DressingInput" })
-- <== }
