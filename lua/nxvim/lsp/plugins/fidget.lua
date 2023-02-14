-- https://github.com/j-hui/fidget.nvim

local fidget = require("fidget")

-- { == Configuration ==> =====================================================

local config = {
	text = {
		done = "",
	},
	window = {
		blend = 0, -- interferes with transparency in TUI
	},
	sources = {
		ltex = {
			ignore = true,
		},
	},
}

if vim.g.nx_loaded_gui then config.window.blend = 100 end

fidget.setup(config)
-- <== }
