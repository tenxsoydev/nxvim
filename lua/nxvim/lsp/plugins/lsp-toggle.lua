-- https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim

require("toggle_lsp_diagnostics").init()

-- Keymaps ====================================================================

nx.map({
	{ "<leader>dtd", "<Cmd>ToggleDiagDefault<CR>", desc = "Toggle Diagnostics Default" },
	{ "<leader>dtv", "<Plug>(toggle-lsp-diag-vtext)", desc = "Toggle Virtual Text" },
})
nx.map({
	{ "<leader>tDd", "<Cmd>ToggleDiagDefault<CR>", desc = "Toggle Diagnostics Default" },
	{ "<leader>tDv", "<Plug>(toggle-lsp-diag-vtext)", desc = "Toggle Virtual Text" },
}, { wk_label = { sub_desc = "Toggle" } })
