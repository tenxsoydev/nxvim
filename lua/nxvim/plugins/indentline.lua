-- https://github.com/lukas-reineke/indent-blankline.nvim

-- { == Configuration ==> =====================================================

-- "▏" "│" "▎" "⎸"" "¦" "┆" "" "┊" ""
local indent_char = "▏"
if not vim.g.neovide and (vim.g.loaded_gui or vim.env.TERM_PROGRAM == "WezTerm") then indent_char = "│" end

require("indent_blankline").setup({
	char = indent_char,
	context_char = indent_char,
	show_end_of_line = true,
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
	show_first_indent_level = true,
	show_trailing_blankline_indent = false,
	use_treesitter = true,
	context_patterns = { -- Works with treesitter contexts
		"class",
		"return",
		"function",
		"method",
		"^if",
		"^while",
		"jsx_element",
		"^for",
		"^object",
		"^array",
		"^table",
		"block",
		"arguments",
		"if_statement",
		"else_clause",
		"jsx_element",
		"jsx_self_closing_element",
		"try_statement",
		"catch_clause",
		"import_statement",
		"operation_type",
		"element",
	},
	context_pattern_highlight = {
		element = "LineNr",
	},
	buftype_exclude = { "terminal", "nofile" },
	filetype_exclude = {
		"help",
		"startify",
		"dashboard",
		"packer",
		"neogitstatus",
		"NvimTree",
		"Trouble",
		"md",
	},
})
-- <== }
