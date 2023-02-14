-- https://github.com/numToStr/Comment.nvim

-- { == Configuration ==> =====================================================

require("Comment").setup({
	mappings = {
		basic = true,
		extra = false,
		extended = false,
	},
})
-- <== }

-- { == Keymaps ==> ===========================================================

local toggle = require("Comment.api").toggle

nx.map({
	-- GUIs + some TUIs (e.g, kitty) can map <C-/> directly
	{ "<C-/>", toggle.linewise.current, { "n", "i" }, desc = "Toggle Line Comment" },
	-- {"<C-/>", function() toggle.linewise(vim.fn.visualmode()) end, "v",  desc = "Toggle Line Comment" },
	{
		"<C-/>",
		"<Esc><Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
		"v",
		desc = "Toggle Line Comment",
	},
	{ "<leader><C-/>", toggle.blockwise.current, desc = "Toggle Block Comment", wk_label = "ignore" },
	{
		"<leader><C-/>",
		function() toggle.blockwise(vim.fn.visualmode()) end,
		"v",
		desc = "Toggle Block Comment",
		wk_label = "ignore",
	},
	-- map '<C-_>' for other TUIs to recognize '<C-/>'
	{ "<C-_>", toggle.linewise.current, { "n", "i" }, desc = "Toggle Line Comment" },
	-- { "<C-_>", function() toggle.linewise(vim.fn.visualmode()) end, "v",  desc = "Toggle Line Comment" },
	{
		"<C-_>",
		"<Esc><Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
		"v",
		desc = "Toggle Line Comment",
	},
	{
		"<leader><C-_>",
		function() toggle.blockwise() end,
		desc = "Toggle Block Comment",
		wk_label = "ignore",
	},
	{
		"<leader><C-_>",
		function() toggle.blockwise(vim.fn.visualmode()) end,
		"v",
		desc = "Toggle Block Comment",
		wk_label = "ignore",
	},
})
-- <== }
