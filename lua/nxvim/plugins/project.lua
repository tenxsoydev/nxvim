-- https://github.com/ahmedkhalf/project.nvim

-- == [ Configuration =========================================================

require("project_nvim").setup({
	-- `:h project.nvim-configuration`
	detection_methods = { "pattern" },
	patterns = { ".git", ".fakeroot" },
})
-- ]

-- == [ Keymaps ===============================================================

nx.map({
	{ "<leader>p", "<Cmd>Telescope projects<CR>", desc = "Projects" },
	{ "<leader>/p", "<Cmd>Telescope projects<CR>", desc = "Search Projects", wk_label = "Projects" },
})

-- ]
