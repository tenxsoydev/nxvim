-- https://github.com/folke/trouble.nvim#%EF%B8%8F-configuration

local function init()
	-- { == Configuration ==> =====================================================

	require("trouble").setup({
		position = "bottom", -- position of the list can be: bottom, top, left, right
		height = 9, -- height of the trouble list when position is top or bottom
		mode = "loclist", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
	})
	-- <== }

	-- Keymaps ====================================================================

	nx.map({
		{ "<leader>dw", "<Cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace Diagnostics" },
		{ "<leader>dT", "<Cmd>TroubleToggle<CR>", desc = "Trouble Toggle" },
		-- { "<leader>tt", "<Cmd>TroubleToggle<CR>", desc = "Trouble" },
		-- { "<leader>q", "<Cmd>TroubleToggle quickfix<CR>", desc = "Quickfix" },
	})
	-- <== }
end

nx.au({ "BufEnter", once = true, pattern = "*.*", callback = init })
