-- https://github.com/Exafunction/codeium.vim

--- { == Keymaps ==> ===========================================================

vim.g.codeium_no_map_tab = true

nx.map({ "<C-Tab>", function() return vim.fn["codeium#Accept"]() end, "i", expr = true })
--- <== }
