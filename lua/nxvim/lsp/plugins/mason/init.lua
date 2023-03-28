-- https://github.com/williamboman/mason.nvim

require("mason").setup({ ui = { border = "rounded" } })

-- { == Keymaps ==> ===========================================================

nx.map({ "<leader>lM", "<Cmd>Mason<CR>" })
-- <== }
