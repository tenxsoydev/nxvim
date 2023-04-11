-- https://github.com/phaazon/hop.nvim

local hop = require("hop")

-- { == Commands ==> ==========================================================

local direction = require("hop.hint").HintDirection
-- funnily using commands fixes hop with dotrepeat
-- ATM it makes a difference in a command instead of mapping the function directly
-- so these commands are just created to be called with keymaps
nx.cmd({
	{
		"HopChar1t",
		function() hop.hint_char1({ direction = direction.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }) end,
	},
	{
		"HopChar1T",
		function() hop.hint_char1({ direction = direction.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }) end,
	},
})
-- <== }

-- { == Keymaps ==> ===========================================================

nx.map({
	-- use commands instead of mapping functions directly as it is compatible with dot repeat
	{ "s", "<Cmd>HopChar2<CR>" },
	{ "S", "<Cmd>HopChar1<CR>" },
	{ "<leader>s", "<Cmd>HopChar2<CR>", "", wk_label = "ignore" },
	{ "<leader>S", "<Cmd>HopChar1<CR>", "", wk_label = "ignore" },
	{ "<leader>j", "<Cmd>HopLineStartAC<cr>", "", wk_label = "ignore" },
	{ "<leader>k", "<Cmd>HopLineStartBC<cr>", "", wk_label = "ignore" },
	{ "f", "<Cmd>HopChar1CurrentLineAC<CR>", "" },
	{ "F", "<Cmd>HopChar1CurrentLineBC<CR>", "" },
	{ "t", "<Cmd>HopChar1t<CR>", "" },
	{ "T", "<Cmd>HopChar1T<CR>", "" },
})
-- <== }

hop.setup()
