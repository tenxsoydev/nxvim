-- https://github.com/TimUntersberger/neogit

local neogit = require("neogit")

-- { == Configuration ==> =====================================================

local config = {
	disable_signs = false,
	disable_hint = false,
	disable_context_highlighting = false,
	disable_commit_confirmation = false,
	disable_insert_on_commit = true,
	-- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
	-- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
	auto_refresh = true,
	disable_builtin_notifications = true,
	use_magit_keybindings = false,
	commit_popup = {
		kind = "split",
	},
	-- Change the default way of opening neogit
	kind = "tab",
	-- customize displayed signs
	signs = {
		-- { CLOSED, OPENED }
		section = { "", "" },
		item = { "", "" },
		hunk = { "", "" },
	},
	integrations = {
		-- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
		-- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
		--
		-- Requires you to have `sindrets/diffview.nvim` installed.
		-- use {
		--   'TimUntersberger/neogit',
		--   requires = {
		--     'nvim-lua/plenary.nvim',
		--     'sindrets/diffview.nvim'
		--   }
		-- }
		--
		diffview = true,
	},
	-- Setting any section to `false` will make the section not render at all
	sections = {
		untracked = {
			folded = false,
		},
		unstaged = {
			folded = false,
		},
		staged = {
			folded = false,
		},
		stashes = {
			folded = true,
		},
		unpulled = {
			folded = true,
		},
		unmerged = {
			folded = false,
		},
		recent = {
			folded = true,
		},
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
		["B"] = "BranchPopup",
		["<kEnter>"] = "GoToFile",
	},
	commit = {
		send = { ";q", "<leader>e" },
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
