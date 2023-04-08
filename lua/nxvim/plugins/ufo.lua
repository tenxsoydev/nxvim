-- https://github.com/kevinhwang91/nvim-ufo

-- { == Configuration ==> =====================================================

local ufo = require("ufo")

local ft = {
	vim = "indent",
	v = "indent",
	python = { "indent" },
}

local ignored_filetypes = { "markdown", "git", "NeogitStatus" }
for _, key in ipairs(ignored_filetypes) do
	ignored_filetypes[key] = true
	ft[key] = ""
end

ufo.setup({
	open_fold_hl_timeout = 150,
	close_fold_kinds = { "imports", "comment" },
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
	provider_selector = function(_, filetype, _) return ft[filetype] end,
})
-- <== }

-- { == Keymaps ==> ===========================================================

nx.au({
	"BufEnter",
	callback = function()
		if ignored_filetypes[vim.bo.ft] or vim.bo.bt ~= "" then return end

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
	end,
})
-- <== }

if vim.g.colors_name == "dracula" then nx.hl({ "Folded", bg = "DraculaBgLight:bg" }) end
