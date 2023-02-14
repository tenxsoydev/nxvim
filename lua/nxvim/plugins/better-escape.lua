-- https://github.com/max397574/better-escape.nvim

local function init()
	-- { == Configuration ==> ====================================================

	require("better_escape").setup({
		mapping = { "jk" },
	})
	-- <== }
end

-- { == Events ==> ============================================================

nx.au({ "InsertEnter", once = true, callback = init })
-- <== }
