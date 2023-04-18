-- https://github.com/tomasky/bookmarks.nvim

local bm = require("bookmarks")
local actions = require("bookmarks.actions")

-- { == Configuration ==> =====================================================

local config = {
	save_file = vim.fn.stdpath("config") .. "/.bookmarks",
	keywords = {
		["@t"] = " ", -- mark annotation startswith @t ,signs this icon as `Todo`
		["@w"] = " ", -- mark annotation startswith @w ,signs this icon as `Warn`
		["@f"] = "", -- mark annotation startswith @f ,signs this icon as `Fix`
		["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
	},
	signs = {
		add = { hl = "BufferAlternate", text = "", numhl = "BookMarksAddNr", linehl = "BookMarksAddLn" },
		ann = { hl = "BookMarksAnn", text = "", numhl = "BookMarksAnnNr", linehl = "BookMarksAnnLn" },
	},
}
-- <== }

-- { == Commands ==============================================================

nx.cmd({
	"BookmarksTelescope",
	function()
		actions.loadBookmarks()
		vim.defer_fn(function() require("telescope").extensions.bookmarks.list({ prompt_title = "Bookmarks" }) end, 50)
	end,
})
-- <== }

-- { == Keymaps ==> ===========================================================

local function map_keys()
	nx.map({
		{
			"<leader>mm",
			function()
				bm.bookmark_toggle()
				actions.saveBookmarks()
			end,
			desc = "Bookmark toggle",
			wk_label = "Toggle",
		},
		{
			"<leader>ma",
			function()
				bm.bookmark_ann()
				actions.saveBookmarks()
			end,
			desc = "Annotate",
		},
		{ "<leader>mq", bm.bookmark_list, desc = "Open Bookmarks in Quickfix List", wk_label = "Quickfix List" },
		{ "<leader>mj", bm.bookmark_next, desc = "Next" },
		{ "<leader>mk", bm.bookmark_prev, desc = "Prev" },
		{ "<leader>mc", bm.bookmark_clean, desc = "Clean Buffer" },
		{ "<leader>/m", "<Cmd>BookmarksTelescope<CR>", desc = "Search Bookmarks", wk_label = "Bookmarks" },
		{ "<leader>m/", "<Cmd>BookmarksTelescope<CR>", desc = "Search Bookmarks", wk_label = "Search" },
	})
end

-- <== }

-- { == Events ==> ============================================================

config.on_attach = function(_) map_keys() end
-- <== }

bm.setup(config)
