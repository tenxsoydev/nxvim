nx.au({
	-- Check if buffers were changed outside of Vim
	{ "FocusGained", pattern = "*.*", command = "checktime" },
	-- Create parent dir if it doesn't exist
	{ "BufWritePre", command = "call mkdir(expand('<afile>:p:h'), 'p')" },
	-- Reload(execute) on save
	{ "BufWritePost", pattern = "options.lua", command = "source <afile>" },
	-- Filetypes to quick close with `q`
	{
		{ "Filetype", "CmdwinEnter" },
		pattern = { "qf", "help", "man", "startuptime", "vim" },
		callback = function() nx.map({ { "q", "<Cmd>close<CR>", buffer = 0 } }) end,
	},
	-- Delay syntax highlighting for larger files, as it can have a significant impact on performance.
	{
		"BufEnter",
		callback = function()
			if vim.fn.line("$") > 3000 or vim.fn.getfsize(vim.fn.expand("%:p")) > 75000 then
				local ft = vim.bo.ft
				vim.cmd("setlocal ft=")
				vim.schedule(function() vim.cmd("setlocal ft=" .. ft) end)
			end
		end,
	},
	-- Highlight on yank
	{ "TextYankPost", callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 }) end },
	-- QFList - adapt window height to list item count(nxvim.utils function)
	{ "FileType", pattern = "qf", command = "setlocal nobuflisted | call AdjustWindowHeight(3, 10)" },

	-- Filetype Specific ----------------------------------------------------------
	{ "FileType", pattern = "markdown", command = "setlocal wrap ts=2 sw=2" },
	-- { "FileType", pattern = "markdown", callback = function() vim.wo.foldlevel = 99 end },
	{ "FileType", pattern = "teal", once = true, command = "LspToggleAutoFormat silent" },
	{ "FileType", pattern = "python", command = "setlocal noexpandtab ts=3 sw=3" },
})

-- Remember folds
nx.au({
	{
		"BufWinLeave",
		pattern = "*.*",
		callback = function()
			if not vim.bo.filetype:match("saga") then vim.cmd("mkview") end
		end,
	},
	{
		"BufWinEnter",
		pattern = "*.*",
		callback = function()
			if not vim.bo.filetype:match("saga") then vim.cmd("silent! loadview") end
		end,
	},
}, { create_group = "RememberFolds" })

-- Sync marks accross sessions
nx.au({
	{ "FocusLost", command = "wshada!" },
	{
		{ "FocusGained", "UIEnter" },
		callback = function()
			vim.schedule(function() vim.cmd("rshada") end)
		end,
	},
}, { create_group = "SyncMarks" })
-- <== }

-- { == Plugin Autocmds ==> ====================================================

-- Autocmds that are specific to a module are set in that module's config file (`/nxvim/plugins/<modulename>.lua`).
-- This modular approach aims for an uncluttered keymap configuration in case plugins are removed or changed.
-- <== }
