-- https://github.com/neovim/nvim-lspconfig

-- == [ Configuration =========================================================

require("lspconfig.ui.windows").default_options.border = nx.opts.float_win_border

nx.map({
	{ "<leader>lI", "<Cmd>LspInfo<CR>", desc = "Info" },
	{ "<leader>lR", "<Cmd>LspRestart<CR>", desc = "Restart" },
})
-- ]

-- Language server configuration is handled by mason-lspconfig
