-- https://github.com/olimorris/persisted.nvim

-- { == Configuration ==> =====================================================

require("persisted").setup()
-- <== }

-- Keymaps ====================================================================

nx.map({
	{ "<leader>st", "<Cmd>SessionToggle<CR>", desc = "Toggle Session" },
	{ "<leader>s+", "<Cmd>SessionStart<CR>", desc = "Start Session" },
	{ "<leader>s-", "<Cmd>SessionStop<CR>", desc = "Start Session" },
	{ "<leader>ss", "<Cmd>SessionSave<CR>", desc = "Save Session" },
	{ "<leader>sl", "<Cmd>SessionLoadLast<CR>", desc = "Load Last Session" },
	{ "<leader>s.", "<Cmd>SessionLoad<CR>", desc = "Load Last Session in Project" },
	{ "<leader>sf", "<Cmd>SessionLoadFromFile<CR>", desc = "Load Session from File" },
	{ "<leader>sd", "<Cmd>SessionDelete<CR>", desc = "Delete Session" },
	{ "<leader>s/", "<Cmd>Telescope persisted<CR>", desc = "Search Session", wk_label = "Search" },
	{ "<leader>/s", "<Cmd>Telescope persisted<CR>", desc = "Search Sessions", wk_label = "Sessions" },
}, { wk_label = { sub_desc = "Session" } })
-- <== }

-- { == Events ==> ============================================================

nx.au({
	{
		"User",
		pattern = "PersistedLoadPre",
		callback = function()
			vim.defer_fn(function()
				pcall(vim.api.nvim_command, "bw neo-tree")
				pcall(vim.api.nvim_command, "bw diffview")
			end, 100)
		end,
	},
	{
		"User",
		pattern = "PersistedSavePre",
		callback = function()
			vim.cmd("Neotree close")
			vim.cmd("DiffviewClose")
		end,
	},
}, { create_group = "PersistedHooks" })
--- <== }
