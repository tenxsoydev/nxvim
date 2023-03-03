-- https://github.com/nvim-neo-tree

local neo_tree = require("neo-tree")

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- { == Configuration ==> =====================================================

local config = {
	close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	sort_case_insensitive = false, -- used when sorting files and directories in the tree
	sort_function = nil, -- use a custom function for sorting files and directories in the tree
	-- sort_function = function (a,b)
	--       if a.type == b.type then
	--           return a.path > b.path
	--       else
	--           return a.type > b.type
	--       end
	--   end , -- this sorts files and directories descendantly
	hide_root_node = true, -- Hide the root node.
	retain_hidden_root_indent = false, -- IF the root node is hidden, keep the indentation anyhow.
	source_selector = {
		winbar = true,
		statusline = false,
		tab_labels = {
			filesystem = "  Files",
			buffers = " Buffers",
			git_status = " Git ",
			diagnostics = "裂Diagnostics ",
		},
		content_layout = "center",
	},
	default_component_configs = {
		container = {
			enable_character_fade = true,
		},
		indent = {
			indent_size = 2,
			padding = 1, -- extra padding on left hand side
			-- indent guides
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "IndentBlankLineChar",
			-- expander config, needed for nesting files
			with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "ﰊ",
			-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
			-- then these will never be used.
			default = "*",
			highlight = "NeoTreeFileIcon",
		},
		modified = {
			symbol = "[+]",
			highlight = "NeoTreeModified",
		},
		name = {
			trailing_slash = false,
			use_git_status_colors = true,
			highlight = "NeoTreeFileName",
		},
		git_status = {
			symbols = {
				-- Change type
				added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
				-- deleted   = "✖", -- this can only be used in the git_status source
				-- renamed   = "", -- this can only be used in the git_status source
				-- Status type
				-- untracked = "",
				-- ignored   = "",
				-- unstaged  = "",
				-- staged    = "",
				-- conflict  = "",
				deleted = "", -- this can only be used in the git_status source
				renamed = "", -- this can only be used in the git_status source
				untracked = "",
				ignored = "",
				unstaged = "祿",
				staged = "綠",
				conflict = "",
			},
		},
	},
	window = {
		position = "left",
		width = 28,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {},
	},
	nesting_rules = {},
	filesystem = {
		filtered_items = {
			visible = true, -- when true, they will just be displayed differently than normal items
			hide_dotfiles = true,
			hide_gitignored = true,
			hide_by_name = {
				--"node_modules"
			},
			hide_by_pattern = { -- uses glob style patterns
				--"*.meta"
			},
			never_show = { -- remains hidden even if visible is toggled to true
				--".DS_Store",
				--"thumbs.db"
			},
		},
		follow_current_file = true, -- This will find and focus the file in the active buffer every
		-- time the current file is changed while the tree is open.
		group_empty_dirs = false, -- when true, empty folders will be grouped together
		hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
		-- in whatever position is specified in window.position
		-- "open_current",  -- netrw disabled, opening a directory opens within the
		-- window like netrw would, regardless of window.position
		-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
		use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
		-- instead of relying on nvim autocmd events.
		window = {
			mappings = {},
		},
		commands = {
			system_open = function(state)
				local node = state.tree:get_node()
				vim.cmd("silent execute '!xdg-open " .. node.path .. "'")
			end,
			-- Override delete to use trash instead of rm
			delete = function(state)
				local inputs = require("neo-tree.ui.inputs")
				local path = state.tree:get_node().path
				local msg = "Are you sure you want to trash " .. path
				inputs.confirm(msg, function(confirmed)
					if not confirmed then return end

					vim.fn.system({ "trash", vim.fn.fnameescape(path) })
					require("neo-tree.sources.manager").refresh(state.name)
				end)
			end,
			-- over write default 'delete_visual' command to 'trash' x n.
			delete_visual = function(state, selected_nodes)
				local inputs = require("neo-tree.ui.inputs")

				-- get table items count
				function GetTableLen(tbl)
					local len = 0
					for _ in pairs(tbl) do
						len = len + 1
					end
					return len
				end

				local count = GetTableLen(selected_nodes)
				local msg = "Are you sure you want to trash " .. count .. " files ?"
				inputs.confirm(msg, function(confirmed)
					if not confirmed then return end
					for _, node in ipairs(selected_nodes) do
						vim.fn.system({ "trash", vim.fn.fnameescape(node.path) })
					end
					require("neo-tree.sources.manager").refresh(state.name)
				end)
			end,
			-- move_cursor_up = function(state) require("neo-tree.ui.renderer").focus_node(state, nil, true, 1, 3) end,
			-- move_cursor_down = function(state) require("neo-tree.ui.renderer").focus_node(state, nil, true, -1, 3) end,
		},
	},
	buffers = {
		follow_current_file = true, -- This will find and focus the file in the active buffer every
		-- time the current file is changed while the tree is open.
		group_empty_dirs = true, -- when true, empty folders will be grouped together
		show_unloaded = true,
	},
	-- This will use your global notify config by default
	notifications = {
		render = nil, -- "default" | "minimal"
		timeout = nil, -- time in ms
	},
	git_status = {
		window = {
			position = "float",
			mappings = {},
		},
	},
	event_handlers = {},
}
-- <== }

-- { == Events ==> ============================================================

config.event_handlers = {
	{
		event = "neo_tree_window_after_open",
		handler = function(arg)
			if require("nxvim.plugins.windows").auto_maximize and vim.fn.win_gettype(arg.winid) ~= "popup" then
				vim.api.nvim_win_set_width(arg.winid, config.window.width)
			end
		end,
	},
	{
		event = "neo_tree_window_after_close",
		handler = function()
			if require("nxvim.plugins.windows").auto_maximize then vim.cmd("WindowsMaximize") end
		end,
	},
}
-- <== }

-- { == Keymaps ==> ===========================================================

config.window.mappings = {
	--[[ ["<space>"] = { "toggle_node",
		nowait = true, -- disable `nowait` if you have existing combos starting with this char that you want to use
	}, ]]
	["<space>"] = "",
	["<2-LeftMouse>"] = "open",
	["<cr>"] = "open",
	["<kEnter>"] = "open",
	["l"] = "open",
	["s"] = "open_split",
	["v"] = "open_vsplit",
	-- ["S"] = "split_with_window_picker",
	-- ["s"] = "vsplit_with_window_picker",
	["t"] = "open_tabnew",
	["w"] = "open_with_window_picker",
	["C"] = "close_node",
	["h"] = "close_node",
	["z"] = "close_all_nodes",
	["Z"] = "expand_all_nodes",
	["gp"] = "focus_preview",
	["a"] = {
		"add",
		-- some commands may take optional config options, see `:h neo-tree-mappings` for details
		config = {
			show_path = "none", -- "none", "relative", "absolute"
		},
	},
	["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
	["d"] = "delete",
	["r"] = "rename",
	["<F2>"] = "rename",
	["y"] = "copy_to_clipboard",
	["x"] = "cut_to_clipboard",
	["p"] = "paste_from_clipboard",
	["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
	-- ["c"] = {
	--  "copy",
	--  config = {
	--    show_path = "none" -- "none", "relative", "absolute"
	--  }
	--}
	["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
	["q"] = "close_window",
	["R"] = "refresh",
	["?"] = "show_help",
}

config.filesystem.window.mappings = {
	["<bs>"] = "navigate_up",
	["."] = "set_root",
	["H"] = "toggle_hidden",
	["F"] = "fuzzy_finder",
	["<C-i>"] = "fuzzy_finder",
	["<C-/>"] = "fuzzy_finder",
	["D"] = "fuzzy_finder_directory",
	["f"] = "filter_on_submit",
	["<C-f>"] = "filter_on_submit",
	["<c-x>"] = "clear_filter",
	["[g"] = "prev_git_modified",
	["]g"] = "next_git_modified",
	["o"] = "system_open",
	-- ["<C-j>"] = "move_cursor_up",
	-- ["<C-k>"] = "move_cursor_up",
	["/"] = "none",
}

config.git_status.window.mappings = {
	["gs"] = "git_add_file",
	["gS"] = "git_add_all",
	["gu"] = "git_unstage_file",
	["gr"] = "git_revert_file",
	["gc"] = "git_commit",
	["gp"] = "git_push",
	["gg"] = "git_commit_and_push",
}

nx.map({
	{ "<leader>ff", "<Cmd>NeoTreeFloatToggle<CR>", desc = "File Browser" },
	{
		"<leader>,/",
		"<Cmd>Neotree float toggle dir=" .. vim.fn.stdpath("config") .. "<CR>",
		desc = "Config Files Tree",
	},
	{ "<leader>fe", "<Cmd>Neotree<CR>", desc = "Focus File Explorer" },
	-- `NeoTreeShow` will toggle and use the position configured as default.
	-- `Neotree show toggle` on the other hand will use the last window position, including floating windows
	-- it would be neccecary to add the default position e.g. `Neotree right show toggle`
	{ "<leader>te", "<Cmd>NeoTreeShow<CR>", desc = "Toggle File Explorer", wk_label = "File Tree" },
	-- Addition shortcuts to view preset directories
	{
		"<leader>,\\",
		"<Cmd>Neotree float dir=" .. vim.fn.stdpath("data") .. "<CR>",
		desc = "Browse Data Dir",
		wk_label = "ignore",
	},
	{ "<leader>f~", "<Cmd>Neotree float dir=$HOME<CR>", desc = "Browse Home Dir" },
})

nx.au({
	"FileType",
	pattern = "neo-tree-popup",
	callback = function()
		vim.schedule(
			function()
				nx.map({
					{ "<Esc>", "<Esc>", "i" },
					{ "q", "<Cmd>q!<CR>" },
					{ "<C-c>", "<Cmd>q!<CR>" },
				}, { buffer = 0 })
			end
		)
	end,
})
-- <== }

-- { == Load Setup ==> =======================================================-

neo_tree.setup(config)
-- <== }

-- { == Highlights ==> =========================================================

local function set_hls()
	if vim.g.colors_name == "dracula" then
		local colors = require("nxvim.colorschemes.dracula").palette

		nx.hl({
			{ "NeoTreeRootName", fg = "DraculaPurple:fg", italic = true },
			{ "NeoTreeFileName", fg = colors.tree_file_name },
			{ "NeoTreeGitConflict", fg = "NeoTreeGitConflict:fg", italic = true },
			{ "NeoTreeTabActive", fg = colors.tree_file_name },
			{ "NeoTreeTabInactive", fg = "NeoTreeDimText:fg", bg = "DraculaBgDark:bg" },
			{ "NeoTreeTabSeparatorInactive", bg = "DraculaBgDark:bg", fg = "DraculaBgDarker:bg" },
		})
	end

	if vim.g.colors_name == "tokyonight" then
		nx.hl({
			{ "NeoTreeTabActive", link = "NeoTreeNormal" },
			{ "NeoTreeTabInactive", fg = "NeoTreeDimText:fg", bg = "TabLine:bg" },
			{ "NeoTreeTabSeparatorInactive", fg = "TabLine:bg", bg = "TabLine:bg" },
			-- { "NeoTreeTabSeparatorActive", fg = "BufferlineSeparatorSelected:fg", bg = "Normal:bg" },
		})
	end
end

set_hls()
nx.au({ "Colorscheme", callback = set_hls })
-- <== }
