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
	{
		"BufRead",
		callback = function(ev)
			if
				vim.fn.line("$") > 5500
				or #vim.api.nvim_get_current_line() > 500
				or vim.fn.getfsize(vim.fn.expand("%:p")) > 200 * 1024
			then
				-- Disable potentially tasking features if the file has 5.5k+ lines,
				-- is not one long line(e.g. minified .js files), or is more than 200kb size.
				vim.defer_fn(function()
					vim.cmd("TSBufDisable highlight")
					vim.cmd("ColorizerDetachFromBuffer")
					require("rainbow-delimiters").disable(0)
				end, 100)
			end
		end,
	},
})

nx.au({ -- Remember folds
	{ "BufWritePre", pattern = "*.*", callback = function() vim.cmd("mkview") end },
	{ "BufWinEnter", pattern = "*.*", callback = function() vim.cmd("silent! loadview") end },
}, { create_group = "RememberFolds" })

nx.au({ -- Sync marks across sessions
	{ "FocusLost", command = "wshada" },
	-- stylua: ignore
	{ { "FocusGained", "UIEnter" }, callback = function() vim.schedule(function() vim.cmd("rshada") end) end },
}, { create_group = "SyncMarks" })

-- == [ Language Autocmds =====================================================

nx.au({
	{ "FileType", pattern = "markdown", command = "setlocal wrap ts=2 sw=2 cole=2" },
	{ "FileType", pattern = "vb", command = "setlocal et ts=4 sw=4" },
	{ "FileType", pattern = "teal", once = true, command = "LspToggleAutoFormat silent" },
	{ "FileType", pattern = { "python", "zig", "swift", "rust", "ron" }, command = "setlocal noet ts=3 sw=0 sts=0" },
	{ "FileType", pattern = "onyx", command = "setlocal noet ts=4 sts=0 sw=0" },
	{ "BufRead", pattern = { "*.mojo" }, command = "setlocal commentstring=#%s" },
})

vim.filetype.add({
	extension = {
		c3 = "c3",
		c3i = "c3",
		c3t = "c3",
		njk = "html",
		vto = "html",
		onyx = "onyx",
		v = "v",
		vv = "v",
	},
	filename = {
		["v.mod"] = "v",
	},
	pattern = {
		['"*.v_*"'] = "v",
	},
})
-- ]

-- == [ Plugin Autocmds ========================================================

-- Autocmds that are specific to a module are set in that module's config file (`/nxvim/plugins/<modulename>.lua`).
-- This modular approach aims for an uncluttered keymap configuration in case plugins are removed or changed.
-- ]
