-- https://github.com/anuvyklack/pretty-fold.nvim

-- { == Configuration ==> =====================================================

require("pretty-fold").setup({
	sections = {
		left = {
			"content",
			"number_of_folded_lines",
			": ",
			"percentage",
			" ⋯",
		},
		right = {},
	},
	fill_char = "",
	keep_indentation = false,
	-- ft_ignore = { "markdown" },
})
-- <== }
