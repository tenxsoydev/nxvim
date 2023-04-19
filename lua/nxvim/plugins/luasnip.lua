-- https://github.com/L3MON4D3/LuaSnip

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

-- { == Configuration ==> =====================================================

ls.config.set_config({
	history = true,
})
-- <== }

-- { == Snippets ==> ==========================================================

ls.add_snippets("v", {
	s("prnt", {
		t("println('"),
		i(1),
		t("')"),
	}),
	s("dbg", {
		t("// DBG: "),
		t({ "", "println('" }),
		i(1),
		t(" <--')"),
	}),
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
