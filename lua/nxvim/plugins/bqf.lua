-- https://github.com/kevinhwang91/nvim-bqf

-- { == Configuration ==> =====================================================

require("bqf").setup({
	func_map = {
		pscrollup = "<C-y>",
		pscrolldown = "<C-e>",
	},
})
-- <== }

-- { == Highlights ==> ========================================================

nx.hl({ "BqfPreviewBorder", link = "FloatBorder" })
-- <== }
