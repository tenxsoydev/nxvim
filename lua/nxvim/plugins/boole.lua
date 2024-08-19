-- https://github.com/nat-418/boole.nvim

-- == [ Configuration =========================================================

require("boole").setup({
	mappings = {
		increment = "<C-a>",
		decrement = "<C-x>",
	},
	additions = {
		{ "const", "let" },
		{ "left", "right" },
		{ "one", "two", "three" },
		{ "primary", "secondary", "tertiary", "quaternary", "quinary" },
	},
	allow_caps_additions = {
		{ "enable", "disable" },
		-- enable → disable
		-- Enable → Disable
		-- ENABLE → DISABLE
	},
})
-- ]
