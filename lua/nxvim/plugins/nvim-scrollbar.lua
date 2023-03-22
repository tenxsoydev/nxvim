-- https://github.com/petertriho/nvim-scrollbar

-- { == Configuration ==> =====================================================

require("scrollbar").setup({
	handle = {
		blend = vim.g.nx_loaded_gui and 30 or 0,
	},
	handlers = {
		cursor = false,
		diagnostic = true,
		gitsigns = true,
		handle = true,
		search = false,
	},
})

-- <== }
