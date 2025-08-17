-- https://github.com/epwalsh/obsidian.nvim

-- == [ Configuration =========================================================

require("obsidian").setup({
	legacy_commands = false,
	workspaces = {
		{
			name = "personal",
			path = "~/Cerebro/Zettelkasten",
		},
	},
})
-- ]
