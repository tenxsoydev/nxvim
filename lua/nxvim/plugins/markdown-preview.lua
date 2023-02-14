-- https://github.com/iamcco/markdown-preview.nvim

-- { == Configuration ==> =====================================================

nx.set({
	mkdp_theme = "dark",
	mkdp_auto_close = false,
})
-- <== }

-- { == Events ==> ============================================================

nx.map({ "<leader>tp", "<Cmd>MarkdownPreviewToggle<CR>", ft = "markdown", desc = "Toggle Markdown Preview" })
-- <== }
