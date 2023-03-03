local spread = require("spread")

-- { == Keymaps ==> ===========================================================

nx.map({
	{ "<F5>", spread.out, silent = true, desc = "Spread Out" },
	{ { "<S-F5>", "<F17>" }, spread.combine, silent = true, desc = "Spread Combine" },
})
-- <== }
