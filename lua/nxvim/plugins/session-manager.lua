-- https://github.com/Shatur/neovim-session-manager

-- { == Configuration ==> =====================================================

require("session_manager").setup({
	sessions_dir = require("plenary.path"):new(vim.fn.stdpath("data"), "sessions"), -- The directory where the session files will be saved.
	path_replacer = "__", -- The character to which the path separator will be replaced for session files.
	colon_replacer = "++", -- The character to which the colon symbol will be replaced for session files.
	autoload_mode = require("session_manager.config").AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
	autosave_last_session = true, -- Automatically save last session on exit and on session switch.
	autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
	autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
		"gitcommit",
	},
	autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
	max_path_length = 70, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
})
-- <== }

-- Keymaps ====================================================================

nx.map({
	{ "<leader>/s", "<Cmd>SessionManager load_session<CR>", desc = "Search Sessions", wk_label = "Sessions" },
	{ "<leader>s/", "<Cmd>SessionManager load_session<CR>", desc = "Search Session", wk_label = "Search" },
	{ "<leader>ss", "<Cmd>SessionManager save_current_session<CR>", desc = "Save Session", wk_label = "Save" },
	{ "<leader>sl", "<Cmd>SessionManager load_last_session<CR>", desc = "Load Last Session", wk_label = "Load Last" },
	{
		"<leader>s.",
		"<Cmd>SessionManager load_current_dir_session<CR>",
		desc = "Load Current Dirs Last Session",
		wk_label = "Load Current Dirs Last",
	},
	{ "<leader>sd", "<Cmd>SessionManager delete_session<CR>", desc = "Delete Session", wk_label = "Delete" },
})
-- <== }
