-- https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim

require("toggle_lsp_diagnostics").init({ virtual_text = false })

-- Keymaps ====================================================================

nx.map({
	{ "<leader>dtT", "<Cmd>ToggleDiag<CR>", desc = "Toggle Diagnostics" },
	{ "<leader>dtd", "<Cmd>ToggleDiagDefault<CR>", desc = "Toggle Diagnostics Default" },
	{ "<leader>dtv", "<Plug>(toggle-lsp-diag-vtext)", desc = "Toggle Virtual Text" },
})
nx.map({
	{ "<leader>tdT", "<Cmd>ToggleDiag<CR>", desc = "Toggle Diagnostics" },
	{ "<leader>tdd", "<Cmd>ToggleDiagDefault<CR>", desc = "Toggle Diagnostics Default" },
	{ "<leader>tdv", "<Plug>(toggle-lsp-diag-vtext)", desc = "Toggle Virtual Text" },
}, { wk_label = { sub_desc = "Toggle" } })
