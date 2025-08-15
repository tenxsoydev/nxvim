-- https://github.com/echasnovski/mini.nvim

-- == [ Animate ================================================================

if not vim.g.loaded_gui and vim.env.TERM ~= "xterm-kitty" then
	local animate = require("mini.animate")
	local config = {
		-- Cursor path
		cursor = {
			enable = true,
			timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
		},
		-- Vertical scroll; use `neoscroll` instead
		scroll = {
			enable = false,
			timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
			subscroll = animate.gen_subscroll.equal({ max_output_steps = 60 }),
		},
		-- Window resize; Use `windows` instead
		resize = {
			enable = false,
		},
		-- Window open
		open = {
			enable = false,
		},
		-- Window close
		close = {
			enable = false,
		},
	}

	animate.setup(config)
end
-- ]

-- == [ Move ==================================================================

require("mini.move").setup({
	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		left = vim.g.eu_kbd and "ù" or "<A-h>",
		right = vim.g.eu_kbd and "ø" or "<A-l>",
		down = vim.g.eu_kbd and "ú" or "<A-j>",
		up = vim.g.eu_kbd and "ĳ" or "<A-k>",
		-- Move current line in Normal mode
		-- line_left =  vim.g.eu_kbd and"ù" or "<A-h>",
		-- line_right =  vim.g.eu_kbd and"ø" or "<A-l>",
		line_left = "",
		line_right = "",
		line_down = vim.g.eu_kbd and "ú" or "<A-j>",
		line_up = vim.g.eu_kbd and "ĳ" or "<A-k>",
	},
})
-- ]

-- == [ Trailspace ============================================================

require("mini.trailspace").setup()

nx.hl({ "MiniTrailspace", link = "DiagnosticUnderlineHint" })
-- ]
