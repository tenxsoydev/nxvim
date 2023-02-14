-- https://github.com/tomasky/bookmarks.nvim

local bm = require("bookmarks")

-- { == Configuration ==> =====================================================

bm.setup({
	save_file = vim.fn.stdpath("config") .. "/.bookmarks",
	keywords = {
		["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
		["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
		["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
		["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
	},
	signs = {
		add = { hl = "BookMarksAdd", text = "", numhl = "BookMarksAddNr", linehl = "BookMarksAddLn" },
		ann = { hl = "BookMarksAnn", text = "", numhl = "BookMarksAnnNr", linehl = "BookMarksAnnLn" },
	},
})
-- <== }

-- { == Keymaps ==> ===========================================================

nx.map({
	{ "<leader>mm", bm.bookmark_toggle, desc = "Bookmark toggle" },
	{ "<leader>ma", bm.bookmark_ann, desc = "Annotate" },
	{ "<leader>mq", bm.bookmark_list, desc = "Quickfix list" },
	{ "<leader>mj", bm.bookmark_next, desc = "Next" },
	{ "<leader>mk", bm.bookmark_prev, desc = "Prev" },
	{ "<leader>mc", bm.bookmark_clean, desc = "Clean Buffer" },
})
-- <== }
