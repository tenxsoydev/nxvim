-- https://github.com/lewis6991/satellite.nvim

-- { == Configuration ==> =====================================================

require("satellite").setup({
	current_only = false,
	winblend = 0,
	zindex = 40,
	excluded_filetypes = {},
	width = 1,
	handlers = {
		search = {
			enable = true,
		},
		diagnostic = {
			enable = true,
			signs = { "-", "=", "≡" },
			min_severity = vim.diagnostic.severity.HINT,
		},
		gitsigns = {
			enable = true,
			signs = { -- can only be a single character (multibyte is okay)
				add = "▕",
				change = "▕",
				delete = "-",
			},
		},
		marks = {
			-- TODO: contrib hl groups?
			enable = true,
			show_builtins = false, -- shows the builtin marks like [ ] < >
		},
	},
})
-- <== }
