-- https://github.com/mrjones2014/smart-splits.nvim

local M = {}

local smart_splits = require("smart-splits")

-- { == Configuration ==> =====================================================

smart_splits.setup()
-- <== }

-- { == Keymaps ==> ===========================================================

function M.set_maps()
	nx.map({
		{ "<C-Left>", function() smart_splits.resize_left(2) end },
		{ "<C-Right>", function() smart_splits.resize_right(2) end },
		{ "<C-Down>", function() smart_splits.resize_down(2) end },
		{ "<C-Up>", function() smart_splits.resize_up(2) end },
		{ "<C-h>", smart_splits.move_cursor_left, desc = "Go to Left Window" },
		{ "<C-l>", smart_splits.move_cursor_right, desc = "Go to Right Window" },
		{ "<C-j>", smart_splits.move_cursor_down, desc = "Go to Below Window" },
		{ "<C-k>", smart_splits.move_cursor_up, desc = "Go to Above Window" },
	})
end

M.set_maps()
-- <== }

return M
