-- https://github.com/echasnovski/mini.nvim

-- { == Animate ==> ============================================================

local animate = require("mini.animate")

local config = {
	-- Cursor path
	cursor = {
		-- Whether to enable this animation
		enable = true,
		--<function: implements linear total 250ms animation duration>,
		timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
	},
	-- Vertical scroll
	scroll = {
		enable = false,
		-- enable = vim.g.loaded_gui and true or false,
		timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
		subscroll = animate.gen_subscroll.equal({ max_output_steps = 60 }),
	},
	-- Window resize -- we use the animation library that comes with windows.nvim instead
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

if vim.g.loaded_gui then config.cursor.enable = false end
animate.setup(config)

-- Occasionally mini.animate leaves a residue of virtualedit = "all". This ensures that it's removed.
local config_ve = vim.o.virtualedit
nx.au({
	"BufEnter",
	callback = function() vim.wo.virtualedit = config_ve end,
})
-- <== }

-- { == Bufremove ==> =========================================================

require("mini.bufremove").setup()
-- <== }

-- { == Move ==> ==============================================================

require("mini.move").setup({
	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		left = vim.g.osx_eu and "ù" or "<A-h>",
		right = vim.g.osx_eu and "ø" or "<A-l>",
		down = vim.g.osx_eu and "ú" or "<A-j>",
		up = vim.g.osx_eu and "ĳ" or "<A-k>",
		-- Move current line in Normal mode
		line_left = vim.g.osx_eu and "ù" or "<A-h>",
		line_right = vim.g.osx_eu and "ø" or "<A-l>",
		line_down = vim.g.osx_eu and "ú" or "<A-j>",
		line_up = vim.g.osx_eu and "ĳ" or "<A-k>",
	},
})
-- <== }

-- { == Trailspace ==> ========================================================

require("mini.trailspace").setup()

nx.hl({ "MiniTrailspace", link = "DiagnosticUnderlineHint" })
-- <== }
