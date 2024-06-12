-- https://github.com/karb94/neoscroll.nvim

if vim.g.loaded_gui then return end

local neoscroll = require("neoscroll")

-- { == Configuration ==> =====================================================

local config = {
	easing_function = "sine", -- Default easing function.
}
-- <== }

-- { == Keymaps ==> ===========================================================

nx.map({
	-- { "<C-d>", function() neoscroll.ctrl_d({ time = 150, easing = "quintic" }) end },
	-- { "<C-u>", function() neoscroll.ctrl_u({ time = 150, easing = "quintic" }) end },
	{ "<C-d>", function() neoscroll.ctrl_d({ time = 150 }) end },
	{ "<C-u>", function() neoscroll.ctrl_u({ time = 150 }) end },
	{ "<C-e>", function() neoscroll.ctrl_e(-0.1, { time = 100 }) end },
	{ "<C-y>", function() neoscroll.ctrl_y(0.1, { time = 100 }) end },
	{ "<C-b>", function() neoscroll.ctrl_b({ time = 250, easing = "circular" }) end },
	{ "<C-f>", function() neoscroll.ctrl_f({ time = 250, easing = "circular" }) end },
	{
		"z<CR>",
		function()
			vim.opt.so = 12
			vim.defer_fn(function() vim.opt.so = 7 end, 250)
			neoscroll.zt({ half_win_duration = 200 })
		end,
	},
}, { mode = "" })
-- <== }

neoscroll.setup(config)
