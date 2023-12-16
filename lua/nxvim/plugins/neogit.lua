-- https://github.com/TimUntersberger/neogit

local neogit = require("neogit")

-- { == Configuration ==> =====================================================

local config = {
	commit_editor = {
		kind = "split",
	},
	signs = {
		section = { "", "" },
		item = { "", "" },
		hunk = { "", "" },
	},
	integrations = {
		diffview = true,
	},
	mappings = {},
}
-- <== }

-- { == Events ==> ===========================================================

nx.au({ "FileType", pattern = "NeogitCommitMessage", command = "setlocal spell" })
-- <== }

-- { == Keymaps ==> ==========================================================

config.mappings = {
	status = {
		["<kEnter>"] = "GoToFile",
	},
}

nx.map({ "<leader>gn", "<Cmd>Neogit<CR>", desc = "Neogit" })
nx.au({
	{ "Filetype", pattern = "NeogitPushPopup", command = "nnoremap <buffer> F <nop>" },
	{ "Filetype", pattern = "NeogitCommitMessage", command = "setlocal et ts=2 sw=2" },
})
-- <== }

-- { == Highlights ==> =======================================================

if vim.g.colors_name == "dracula" then
	nx.hl({ "NeogitDiffAddHighlight", fg = "DiffAdd:fg", bg = "StatusLineTermNC:bg" })
	-- fix blue difftext in Neogit
	nx.hl({ "NeogitDiffDeleteHighlight", fg = "DraculaDiffDelete:fg", bg = "StatusLineTermNC:bg" })
end
-- <== }

neogit.setup(config)
