-- https://github.com/simrat39/rust-tools.nvim

require("rust-tools").setup({
	server = {
		on_attach = function(client, bufnr)
			require("nxvim.lsp").on_attach(_, bufnr)
			require("nxvim.lsp.plugins.lspsaga").on_attach(_, bufnr)
		end,
	},
})
