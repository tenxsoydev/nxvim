-- https://github.com/L3MON4D3/LuaSnip

local ls = require("luasnip")

-- { == Configuration ==> =====================================================

ls.config.set_config({
	history = true,
})
-- <== }

-- { == Keymaps ==> ===========================================================

nx.map({
	{
		"<C-n>",
		function()
			if ls.expand_or_jumpable() then ls.expand_or_jump() end
		end,
	},
	{
		"<C-p>",
		function()
			if ls.jumpable(-1) then ls.jump(-1) end
		end,
	},
	{
		"<C-g>",
		function()
			if ls.choice_active() then ls.change_choice(1) end
		end,
	},
	{
		"<C-t>",
		function()
			if ls.choice_active() then ls.change_choice(-1) end
		end,
	},
}, { silent = true, mode = { "i", "s" } })
-- <== }
