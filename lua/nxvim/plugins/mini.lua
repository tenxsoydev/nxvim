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
		enable = true,
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

if vim.g.nx_loaded_gui then config.cursor.enable = false end
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
		left = "<A-h>",
		right = "<A-l>",
		down = "<A-j>",
		up = "<A-k>",
		-- Move current line in Normal mode
		line_left = "<A-Left>",
		line_right = "<A-Right>",
		line_down = "<A-j>",
		line_up = "<A-k>",
	},
})
-- <== }

-- { == Trailspace ==> ========================================================

require("mini.trailspace").setup()

nx.hl({"MiniTrailspace", link = "DiagnosticUnderlineHint"})
-- <== }
