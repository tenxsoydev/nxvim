-- https://github.com/williamboman/mason.nvim

-- == [ Configuration =========================================================

require("mason").setup({ ui = { border = nx.opts.float_win_border } })
-- ]

-- == [ Keymaps ===============================================================

nx.map({ "<leader>lM", "<Cmd>Mason<CR>" })
-- ]
