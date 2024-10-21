-- https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim

require("toggle_lsp_diagnostics").init({ virtual_text = true })

-- Keymaps ====================================================================

nx.map({
	{ "<leader>dtd", "<Cmd>ToggleDiagDefault<CR>", desc = "Toggle Diagnostics Default" },
	{ "<leader>dtv", "<Plug>(toggle-lsp-diag-vtext)", desc = "Toggle Virtual Text" },
})
nx.map({
	{ "<leader>tdd", "<Cmd>ToggleDiagDefault<CR>", desc = "Toggle Diagnostics Default" },
	{ "<leader>tdv", "<Plug>(toggle-lsp-diag-vtext)", desc = "Toggle Virtual Text" },
}, { wk_label = { sub_desc = "Toggle" } })
