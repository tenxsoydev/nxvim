-- https://github.com/akinsho/git-conflict.nvim

-- { == Configuration ==> =====================================================

require("git-conflict").setup({
	default_mappings = true, -- https://github.com/akinsho/git-conflict.nvim#mappings
	disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
	highlights = { -- They must have background color, otherwise the default color will be used
		incoming = "DiffText",
		current = "DiffAdd",
	},
})
-- <== }
