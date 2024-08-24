-- https://github.com/petertriho/nvim-scrollbar

-- == [ Configuration =========================================================

require("scrollbar").setup({
	show_in_active_only = true,
	handle = {
		blend = vim.g.loaded_gui and 30 or 0,
	},
	handlers = {
		cursor = false,
		diagnostic = true,
		gitsigns = true,
		handle = true,
		search = true,
	},
})

-- ]
