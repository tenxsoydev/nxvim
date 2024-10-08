-- https://github.com/LintaoAmons/bookmarks.nvim

require("bookmarks").setup({
	signs = {
		mark = { icon = "󰃃", color = "grey" },
		annotation = { icon = "󰆉", color = "grey" },
	},
})

-- == [ Keymaps ===============================================================

nx.map({
	{ "<leader>mm", "<Cmd>BookmarksMark<CR>", desc = "Bookmark toggle", wk_label = "Toggle" },
	{ "<leader>/m", "<Cmd>BookmarksGoto<CR>", desc = "Search Bookmarks", wk_label = "Bookmarks" },
	{ "<leader>m/", "<Cmd>BookmarksGoto<CR>", desc = "Search Bookmarks", wk_label = "Search" },
	{ "<leader>m.", "<Cmd>BookmarksGotoRecent<CR>", desc = "Search Bookmarks", wk_label = "Search" },
})
-- ]
