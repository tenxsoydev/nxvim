-- https://github.com/mrjones2014/smart-splits.nvim

-- { == Configuration ==> =====================================================

require("smart-splits").setup({
	tmux_integration = false,
})
-- <== }

-- { == Keymaps ==> ===========================================================

nx.map({
	{ "<C-Left>", "<Cmd>SmartResizeLeft 2<CR>" },
	{ "<C-Right>", "<Cmd>SmartResizeRight 2<CR>" },
	{ "<C-Down>", "<Cmd>SmartResizeDown 2<CR>" },
	{ "<C-Up>", "<Cmd>SmartResizeUp 2<CR>" },
	{ "<C-h>", "<Cmd>SmartCursorMoveLeft<CR>", desc = "Go to Left Window" },
	{ "<C-l>", "<Cmd>SmartCursorMoveRight<CR>", desc = "Go to Right Window" },
	{ "<C-j>", "<Cmd>SmartCursorMoveDown<CR>", desc = "Go to Bottom Window" },
	{ "<C-k>", "<Cmd>SmartCursorMoveUp<CR>", desc = "Go to Top Window" },
})
-- <== }
