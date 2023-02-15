-- https://github.com/simrat39/rust-tools.nvim

local function init()
	require("rust-tools").setup({
		server = {
			on_attach = function(_, bufnr)
				require("nxvim.lsp").on_attach()
				require("nxvim.lsp.plugins.lspsaga").on_attach()
			end,
		},
	})
end

nx.au({ "Filetype", once = true, pattern = "rust", callback = init })
