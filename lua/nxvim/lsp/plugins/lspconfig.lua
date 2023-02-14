-- https://github.com/neovim/nvim-lspconfig

-- { == Configuration ==> =====================================================

require("lspconfig.ui.windows").default_options.border = "rounded"

nx.map({
	{ "<leader>lI", "<Cmd>LspInfo<CR>", desc = "Info" },
	{ "<leader>lR", "<Cmd>LspRestart<CR>", desc = "Restart" },
})
-- <== }

-- Language server configuration is handled by mason-lspconfig
