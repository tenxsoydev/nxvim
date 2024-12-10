-- https://github.com/rcarriga/nvim-notify#usage
local notify = require("notify")

-- == [ Configuration =========================================================

notify.setup({
	render = "minimal", -- Render function for notifications. See notify-render()
	timeout = 2500, -- Default timeout for notifications
	minimum_width = 10, -- Minimum width for notification windows
	background_color = "none",
	-- stages = "fade_in_slide_out",
	-- Move notifications to bottom right corner
	--[[ stages = {
		function(state)
			local stages_util = require "notify.stages.util"

			local next_height = state.message.height + 2
			local next_row =
				stages_util.available_slot(state.open_windows, next_height, stages_util.DIRECTION.BOTTOM_UP)
			if not next_row then return nil end
			return {
				relative = "editor",
				anchor = "NE",
				width = state.message.width,
				height = state.message.height,
				col = vim.opt.columns:get(),
				row = next_row,
				border = nx.opts.float_win_border,
				style = "minimal",
				opacity = 0,
			}
		end,
		function()
			return {
				opacity = { 100 },
				col = { vim.opt.columns:get() },
			}
		end,
		function()
			return {
				col = { vim.opt.columns:get() },
				time = true,
			}
		end,
		function()
			return {
				width = {
					1,
					frequency = 2.5,
					damping = 0.9,
					complete = function(cur_width) return cur_width < 3 end,
				},
				opacity = {
					0,
					frequency = 2,
					complete = function(cur_opacity) return cur_opacity <= 4 end,
				},
				col = { vim.opt.columns:get() },
			}
		end,
	}, ]]
})
-- ]

vim.notify = notify
