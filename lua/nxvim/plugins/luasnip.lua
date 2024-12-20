-- https://github.com/L3MON4D3/LuaSnip

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

-- == [ Configuration =========================================================

ls.config.set_config({
	history = true,
})
-- ]

-- == [ Snippets ==============================================================

ls.filetype_extend("typescript", { "javascript" })
ls.add_snippets("v", {
	s("prt", fmt("println('{}')", { c(1, { sn(nil, { t("${"), i(1), t("}") }), t("") }) })),
})
-- ]

-- == [ Keymaps ===============================================================

nx.map({
	{
		"<C-j>",
		function()
			if ls.expand_or_jumpable() then ls.expand_or_jump() end
		end,
	},
	{
		"<C-k>",
		function()
			if ls.jumpable(-1) then ls.jump(-1) end
		end,
	},
	{
		"<C-S-j>",
		function()
			if ls.choice_active() then ls.change_choice(1) end
		end,
	},
	{
		"<C-S-k>",
		function()
			if ls.choice_active() then ls.change_choice(-1) end
		end,
	},
}, { silent = true, mode = { "i", "s" } })
-- ]
