-- https://github.com/kevinhwang91/nvim-ufo

-- == [ Configuration =========================================================

local ufo = require("ufo")

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
	enable_get_fold_virt_text = false,
	provider_selector = function(bufnr, filetype, buftype)
		for _, type in ipairs({ "markdown", "yaml" }) do
			if filetype == type then return { "treesitter", "indent" } end
		end
	end,
})
-- ]

-- == [ Keymaps ===============================================================

nx.map({
	{ "zR", ufo.openAllFolds },
	{ "zM", ufo.closeAllFolds },
	{ "zr", ufo.openFoldsExceptKinds },
	{ "zm", ufo.closeFoldsWith },
	{ "zp", ufo.peekFoldedLinesUnderCursor },
})
-- ]

if vim.g.colors_name == "dracula" then nx.hl({ "Folded", fg = "SignColumn:fg", bg = "DraculaBgLight:bg" }) end
