-- https://github.com/kevinhwang91/nvim-ufo

-- { == Configuration ==> =====================================================

local ufo = require("ufo")

local ignored_filetypes = { "markdown", "git", "NeogitStatus" }
for _, key in ipairs(ignored_filetypes) do
	ignored_filetypes[key] = true
end

ufo.setup({
	open_fold_hl_timeout = 150,
	close_fold_kinds_for_ft = {
		default = { "imports", "comment" },
		markdown = {},
		git = {},
		NeogitStatus = {},
	},
	preview = {
		win_config = {
			border = { "", "─", "", "", "", "─", "", "" },
			winhighlight = "Normal:Folded",
			winblend = 0,
		},
		mappings = {
			scrollU = "<C-u>",
			scrollD = "<C-d>",
			jumpTop = "[",
			jumpBot = "]",
		},
	},
	provider_selector = function(_, ft, _) return not ignored_filetypes[ft] end,
})
-- <== }

-- { == Keymaps ==> ===========================================================

nx.map({
	{ "zR", ufo.openAllFolds },
	{ "zM", ufo.closeAllFolds },
	{ "zr", ufo.openFoldsExceptKinds },
	{ "zm", ufo.closeFoldsWith },
	{
		"K",
		function()
			local winid = ufo.peekFoldedLinesUnderCursor()
			if not winid then vim.lsp.buf.hover() end
		end,
	},
}, { buffer = true })
-- <== }

if vim.g.colors_name == "dracula" then nx.hl({ "Folded", fg = "SignColumn:fg", bg = "DraculaBgLight:bg" }) end
