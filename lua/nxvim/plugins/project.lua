-- https://github.com/ahmedkhalf/project.nvim

-- == [ Configuration =========================================================

require("project_nvim").setup({
	detection_methods = { "pattern" },
	patterns = { ".git" }, -- { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
})
-- ]

-- == [ Keymaps ===============================================================

nx.map({
	{ "<leader>p", "<Cmd>Telescope projects<CR>", desc = "Projects" },
	{ "<leader>/p", "<Cmd>Telescope projects<CR>", desc = "Search Projects", wk_label = "Projects" },
})

-- ]
