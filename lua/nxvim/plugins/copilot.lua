local function init()
	require("copilot").setup({
		suggestion = { enabled = false },
		panel = { enabled = false },
	})
end

-- { == Events ==> ============================================================

nx.au({
	"InsertEnter",
	once = true,
	callback = function()
		init()
		-- pseudo buffer switch to display copilot after init as lsp
		vim.defer_fn(function()
			if vim.fn.win_gettype(0) == "popup" then return end

			vim.cmd("help | horiz resize 1  | quit")
		end, 400)
	end,
})
-- <== }
