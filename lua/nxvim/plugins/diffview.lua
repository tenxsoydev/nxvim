local function init()
	local diffview = require("diffview")

	-- { == Configuration ==> =====================================================

	local config = {
		diff_binaries = false, -- Show diffs for binaries
		enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
		use_icons = true, -- Requires nvim-web-devicons
		icons = { -- Only applies when use_icons is true.
			folder_closed = "",
			folder_open = "",
		},
		signs = {
			fold_closed = "",
			fold_open = "",
		},
		file_panel = {
			win_config = {
				position = "left", -- One of 'left', 'right', 'top', 'bottom'
				width = 34, -- Only applies when position is 'left' or 'right'
				height = 10, -- Only applies when position is 'top' or 'bottom'
			},
			listing_style = "tree", -- One of 'list' or 'tree'
			tree_options = { -- Only applies when listing_style is 'tree'
				flatten_dirs = true, -- Flatten dirs that only contain one single dir
				folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
			},
		},
		file_history_panel = {
			win_config = {
				position = "bottom",
				-- width = 35,
				height = 10,
			},
		},
		default_args = { -- Default args prepended to the arg-list for the listed commands
			DiffviewOpen = {},
			DiffviewFileHistory = {},
		},
		hooks = {}, -- See ':h diffview-config-hooks'
		key_bindings = {}, -- See Keymap section below
	}
	-- <== }

	-- { == Keymaps ==> ==========================================================

	local cb = require("diffview.config").diffview_callback

	config.key_bindings = {
		disable_defaults = false, -- Disable the default key bindings
		-- The `view` bindings are active in the diff buffers, only when the current
		-- tabpage is a Diffview.
		view = {
			["<tab>"] = cb("select_next_entry"), -- Open the diff for the next file
			["<s-tab>"] = cb("select_prev_entry"), -- Open the diff for the previous file
			["gf"] = cb("goto_file_edit"), -- Open the file in a new split in previous tabpage
			["<C-w><C-f>"] = cb("goto_file_split"), -- Open the file in a new split
			["<C-w>gf"] = cb("goto_file_tab"), -- Open the file in a new tabpage
			-- ["<leader>e"] = cb "focus_files", -- Bring focus to the files panel
			-- ["<leader>b"] = cb "toggle_files", -- Toggle the files panel.
			["<leader>fe"] = cb("focus_files"), -- Bring focus to the files panel
			["<leader>te"] = cb("toggle_files"), -- Toggle the files panel.
		},
		file_panel = {
			["<j>"] = cb("next_entry"), -- Bring the cursor to the next file entry
			-- ["<C-j>"] = cb "next_entry", -- Bring the cursor to the next file entry
			-- ["j"] = cb "select_next_entry", -- Open the diff for the next file
			["<down>"] = cb("next_entry"),
			["k"] = cb("prev_entry"), -- Bring the cursor to the previous file entry.
			-- ["<C-k>"] = cb "prev_entry", -- Bring the cursor to the previous file entry.
			-- ["k"] = cb "select_prev_entry", -- Open the diff for the previous file
			["<up>"] = cb("prev_entry"),
			["<cr>"] = cb("select_entry"), -- Open the diff for the selected entry.
			["o"] = cb("select_entry"),
			["<2-LeftMouse>"] = cb("select_entry"),
			["s"] = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
			["S"] = cb("stage_all"), -- Stage all entries.
			["U"] = cb("unstage_all"), -- Unstage all entries.
			["X"] = cb("restore_entry"), -- Restore entry to the state on the left side.
			["R"] = cb("refresh_files"), -- Update stats and entries in the file list.
			["<tab>"] = cb("select_next_entry"),
			["<s-tab>"] = cb("select_prev_entry"),
			["gf"] = cb("goto_file_edit"),
			["<C-w><C-f>"] = cb("goto_file_split"),
			["<C-w>gf"] = cb("goto_file_tab"),
			["i"] = cb("listing_style"), -- Toggle between 'list' and 'tree' views
			["f"] = cb("toggle_flatten_dirs"), -- Flatten empty subdirectories in tree listing style.
			["<leader>e"] = cb("focus_files"),
			["<leader>b"] = cb("toggle_files"),
		},
		file_history_panel = {
			["g!"] = cb("options"), -- Open the option panel
			["<C-A-d>"] = cb("open_in_diffview"), -- Open the entry under the cursor in a diffview
			["y"] = cb("copy_hash"), -- Copy the commit hash of the entry under the cursor
			["zR"] = cb("open_all_folds"),
			["zM"] = cb("close_all_folds"),
			["j"] = cb("next_entry"),
			["<down>"] = cb("next_entry"),
			["k"] = cb("prev_entry"),
			["<up>"] = cb("prev_entry"),
			["<cr>"] = cb("select_entry"),
			["o"] = cb("select_entry"),
			["<2-LeftMouse>"] = cb("select_entry"),
			["<tab>"] = cb("select_next_entry"),
			["<s-tab>"] = cb("select_prev_entry"),
			["gf"] = cb("goto_file_edit"),
			["<C-w><C-f>"] = cb("goto_file_split"),
			["<C-w>gf"] = cb("goto_file_tab"),
			["<leader>e"] = cb("focus_files"),
			["<leader>b"] = cb("toggle_files"),
		},
		option_panel = {
			["<tab>"] = cb("select"),
			["q"] = cb("close"),
		},
	}
	-- <== }

	-- { == Load Setup ==> =======================================================

	diffview.setup(config)
	-- <== }

	-- { == Highlights ==> =======================================================

	if vim.g.colors_name == "dracula" then
		local palette = require("nxvim.colorschemes.dracula").palette
		nx.hl({
			{ "DiffViewFilePanelFileName", fg = palette.tree_file_name },
			{ "DiffViewFilePanelCounter", fg = palette.tree_file_name },
		})
	end
	-- <== }
end

-- Pre-loaded keymaps - allow init via shortcut
nx.map({
	{ "<leader>gd", "<Cmd>DiffviewToggle<CR>", desc = "Toggle Diffview", wk_label = "Diffview" },
	{ "<leader>gh", "<Cmd>DiffviewFileHistory %<CR>", desc = "Diffview File History", wk_label = "File History" },
})

-- { == Commands ==> ==========================================================

nx.cmd({
	"DiffviewToggle",
	function(e)
		local view = require("diffview.lib").get_current_view()
		if not vim.g.nx_loaded_diffview then
			-- use custom loaded var as `diffview_nvim_loaded` is also true when `diffview.setup()` was not called
			vim.g.nx_loaded_diffview = 1
			init()
		end

		if view then
			vim.cmd("DiffviewClose")
		else
			vim.cmd("DiffviewOpen " .. e.args)
		end
	end,
	nargs = "*",
})
-- <== }
