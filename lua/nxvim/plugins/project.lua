-- https://github.com/ahmedkhalf/project.nvim

-- { == Configuration ==> =====================================================

require("project_nvim").setup({
	detection_methods = { "pattern" },
	-- ignore_lsp = {},
})
-- <== }

-- { == Keymaps ==> ===========================================================

nx.map({
	{ "<leader>p", "<Cmd>Telescope projects<CR>", desc = "Projects" },
	{ "<leader>/p", "<Cmd>Telescope projects<CR>", desc = "Search Projects", wk_label = "Projects" },
})

-- <== }
