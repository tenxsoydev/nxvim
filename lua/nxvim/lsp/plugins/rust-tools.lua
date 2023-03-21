-- https://github.com/simrat39/rust-tools.nvim

require("rust-tools").setup({
	server = {
		on_attach = function(client, bufnr)
			require("nxvim.lsp").on_attach(_, bufnr)
			require("nxvim.lsp.plugins.lspsaga").on_attach(_, bufnr)
			if vim.g.colors_name == "dracula" then
				vim.schedule(function() vim.lsp.semantic_tokens.stop(bufnr, client.id) end)
				nx.cmd({
					{ "DisableSTH", function() vim.lsp.semantic_tokens.stop(bufnr, client.id) end },
					{ "EnableSTH", function() vim.lsp.semantic_tokens.start(bufnr, client.id) end },
				})
			end
		end,
	},
})
