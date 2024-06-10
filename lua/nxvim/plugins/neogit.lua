-- https://github.com/TimUntersberger/neogit

local neogit = require("neogit")

-- { == Configuration ==> =====================================================

local config = {
	commit_editor = {
		kind = "split",
	},
	signs = {
		-- section = { "", "" },
		section = { "", "" },
		item = { "", "" },
		hunk = { "", "" },
	},
	integrations = {
		diffview = true,
	},
	mappings = {},
}
-- <== }

-- { == Events ==> ===========================================================

nx.au({
	"Filetype",
	pattern = "NeogitCommitMessage",
	callback = function()
		vim.defer_fn(function() vim.o.spell = true end, 100)
	end,
})
-- { "Filetype", pattern = "NeogitCommitMessage", command = "setlocal spell et ts=2 sw=2" },
-- <== }

-- { == Keymaps ==> ==========================================================

config.mappings = {
	status = {
		["<kEnter>"] = "GoToFile",
	},
}

nx.map({ "<leader>gn", "<Cmd>Neogit<CR>", desc = "Neogit" })
-- <== }

-- { == Highlights ==> =======================================================

if vim.g.colors_name == "dracula" then
	nx.hl({ "NeogitDiffAddHighlight", fg = "DiffAdd:fg", bg = "StatusLineTermNC:bg" })
	-- fix blue difftext in Neogit
	nx.hl({ "NeogitDiffDeleteHighlight", fg = "DraculaDiffDelete:fg", bg = "StatusLineTermNC:bg" })
end
-- <== }

neogit.setup(config)
