nx.au({
	-- Check if buffers were changed outside of Vim
	{ "FocusGained", pattern = "*.*", command = "checktime" },
	-- Create parent dir if it doesn't exist
	{ "BufWritePre", command = "call mkdir(expand('<afile>:p:h'), 'p')" },
	-- Reload(execute) on save
	{ "BufWritePost", pattern = "options.lua", command = "source <afile>" },
	{ -- Filetypes to quick close with `q`
		{ "Filetype", "CmdwinEnter" },
		pattern = { "qf", "help", "man", "startuptime", "vim" },
		callback = function() nx.map({ { "q", "<Cmd>close<CR>", buffer = 0 } }) end,
	},
	{ -- Disable auto commenting
		"BufEnter",
		command = "setlocal formatoptions-=cro",
	},
	-- Highlight on yank
	{ "TextYankPost", callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 }) end },
	-- QFList - adapt window height to list item count(nxvim.utils function)
	{ "FileType", pattern = "qf", command = "setlocal nobuflisted | call AdjustWindowHeight(3, 10)" },

	-- Filetype Specific ----------------------------------------------------------
	{ "FileType", pattern = "markdown", command = "setlocal wrap ts=2 sw=2" },
	-- { "FileType", pattern = "markdown", callback = function() vim.wo.foldlevel = 99 end },
	{ "FileType", pattern = "teal", once = true, command = "LspToggleAutoFormat silent" },
	{ "FileType", pattern = "python", command = "setlocal noet ts=3 sw=3" },
	{ "FileType", pattern = "vb", command = "setlocal et ts=4 sw=4" },
})

nx.au({ -- Remember folds
	{ "BufWinLeave", pattern = "*.*", callback = function() vim.cmd("mkview") end },
	{ "BufWinEnter", pattern = "*.*", callback = function() vim.cmd("silent! loadview") end },
}, { create_group = "RememberFolds" })

nx.au({ -- Sync marks accross sessions
	{ "FocusLost", command = "wshada" },
	-- stylua: ignore
	{ { "FocusGained", "UIEnter" }, callback = function() vim.schedule(function() vim.cmd("rshada") end) end },
}, { create_group = "SyncMarks" })
-- <== }

-- { == Plugin Autocmds ==> ====================================================

-- Autocmds that are specific to a module are set in that module's config file (`/nxvim/plugins/<modulename>.lua`).
-- This modular approach aims for an uncluttered keymap configuration in case plugins are removed or changed.
-- <== }
