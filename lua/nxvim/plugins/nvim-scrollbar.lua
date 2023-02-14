-- https://github.com/petertriho/nvim-scrollbar

-- { == Configuration ==> =====================================================

require("scrollbar").setup({
	handlers = {
		cursor = false,
		diagnostic = true,
		gitsigns = true,
		handle = true,
		search = false,
	},
})

-- <== }
