local spread = require("spread")

-- { == Keymaps ==> ===========================================================

nx.map({
	{ "<F4>", spread.out, silent = true, desc = "Spread Out" },
	{ { "<S-F4>", "<F16>" }, spread.combine, silent = true, desc = "Spread Combine" },
})
-- <== }
