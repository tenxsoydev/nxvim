-- https://github.com/vigoux/notifier.nvim

-- { == Configuration ==> =====================================================

require("notifier").setup({
	components = {
		"nvim", -- Nvim notifications (vim.notify and such)
		-- "lsp"  -- LSP status updates
	},
	notify = {
		clear_time = 5000, -- Time in milliseconds before removing a vim.notify notification, 0 to make them sticky
	},
	zindex = 100,
})
-- <== }
