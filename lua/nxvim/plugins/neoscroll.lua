-- https://github.com/karb94/neoscroll.nvim

local neoscroll = require("neoscroll")

-- { == Configuration ==> =====================================================

local config = {
	-- All these keys will be mapped to their corresponding default scrolling animation
	mappings = {}, -- See keymaps section below
	hide_cursor = true, -- Hide cursor while scrolling
	stop_eof = true, -- Stop at <EOF> when scrolling downwards
	use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
	respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
	cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
	easing_function = "sine", -- Default easing function
	pre_hook = nil, -- Function to run before the scrolling animation starts
	post_hook = nil, -- Function to run after the scrolling animation ends
	performance_mode = false, -- Disable "Performance Mode" on all buffers.}
}
-- <== }

-- { == Keymaps ==> ===========================================================

config.mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" }

-- Mapping overrides for custom easing function / animation length
local t = {}
t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "250", "circular" } }
t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "250", "circular" } }
-- Pass "nil" to disable the easing animation (constant scrolling speed)
-- When no easing function is provided the default easing function will be used
t["<C-y>"] = { "scroll", { "-0.10", "false", "100" } }
t["<C-e>"] = { "scroll", { "0.10", "false", "100" } }
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "150", "sine" } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "150", "sine" } }
-- t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "175", "quintic" } }
-- t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "175", "quintic" } }
-- t['zt']    = { 'zt', { '300' } }
-- t['zz']    = { 'zz', { '300' } }
-- t['zb']    = { 'zb', { '300' } }
-- <== }

neoscroll.setup(config)
require("neoscroll.config").set_mappings(t)
