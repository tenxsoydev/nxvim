-- https://github.com/mattn/vim-gist

-- == [ Configuration =========================================================

vim.g.gist_open_browser_after_post = 1
-- ]

-- == [ Keymaps ===============================================================

nx.map({
	{ "<leader>gGa", "<Cmd>Gist -b -a<CR>", desc = "Create Anonymous Gist", wk_label = " Create Anonymous" },
	{ "<leader>gGd", "<Cmd>Gist -d<CR>", desc = "Delete Gist", wk_label = "Delete" },
	{ "<leader>gGf", "<Cmd>Gist -f<CR>", desc = "Fork Gist", wk_label = "Fork" },
	{ "<leader>gGp", "<Cmd>Gist -b<CR>", desc = "Create Gist", wk_label = "Create" },
	{ "<leader>gGl", "<Cmd>Gist -l<CR>", desc = "List Gist", wk_label = "List" },
	{ "<leader>gGp", "<Cmd>Gist -b -p<CR>", desc = "Create Private Gist", wk_label = "Create Private" },
})
-- ]
