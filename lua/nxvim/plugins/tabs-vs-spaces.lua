-- https://github.com/tenxsoydev/tabs-vs-spaces.nvim

require("tabs-vs-spaces").setup()

-- == [ Keymaps ===============================================================

nx.map({ "<leader>t<Tab>", "<Cmd>TabsVsSpacesToggle<CR>" })
-- ]
