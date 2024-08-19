-- https://github.com/j-hui/fidget.nvim

local fidget = require("fidget")

-- == [ Configuration =========================================================

local config = {
	progress = {
		display = {
			done_icon = "",
		},
	},
	notification = {
		window = {
			normal_hl = "Float",
			winblend = 0,
		},
	},
}

if vim.g.loaded_gui then config.notification.window.winblend = 100 end

fidget.setup(config)
-- ]
