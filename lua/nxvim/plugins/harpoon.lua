-- https://github.com/ThePrimeagen/harpoon

require("harpoon").setup()

-- == [ Keymaps ===============================================================

local harpoon_ui = require("harpoon.ui")

nx.map({
	{ { "mh/", "<S-m>/" }, function() harpoon_ui.toggle_quick_menu() end, desc = "Search Harpoons" },
	{ { "mh1", "<S-m>1" }, function() harpoon_ui.nav_file(1) end, desc = "Go to Harpoon #1" },
	{ { "mh2", "<S-m>2" }, function() harpoon_ui.nav_file(2) end, desc = "Go to Harpoon #2" },
	{ { "mh3", "<S-m>3" }, function() harpoon_ui.nav_file(3) end, desc = "Go to Harpoon #3" },
	{ { "mh4", "<S-m>4" }, function() harpoon_ui.nav_file(4) end, desc = "Go to Harpoon #4" },
	-- stylua: ignore
	{ "<S-m>a", function() require("harpoon.mark").add_file() end, desc = "Harpoon Current File", wk_label =  "Add Current File" },
}, { wk_label = { sub_desc = "Harpoon[s]?" } })

nx.map({
	{ "<C-p>", "<C-p>" },
	{ { "<C-c>", "<Esc>" }, "<Cmd>close<CR>" },
}, { buffer = 0, silent = true, ft = "harpoon" })
-- ]

-- == [ Highlights ============================================================

nx.hl({ "HarpoonBorder", link = "FloatBorder" })
-- ]
