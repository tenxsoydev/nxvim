-- https://github.com/nvim-neo-tree

local neo_tree = require("neo-tree")

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- { == Configuration ==> =====================================================

local config = {
	close_if_last_window = false,
	popup_border_style = nx.opts.float_win_border,
	enable_git_status = true,
	enable_diagnostics = true,
	sort_case_insensitive = false,
	sort_function = nil,
	hide_root_node = true,
	retain_hidden_root_indent = false,
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
				added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = "",
				renamed = "",
				untracked = "",
				ignored = "",
				unstaged = "",
				staged = "",
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
		mappings = {}, -- See keymaps section below
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
		follow_current_file = true,
		group_empty_dirs = false,
		hijack_netrw_behavior = "open_default",
		use_libuv_file_watcher = false,
		commands = {
			system_open = function(state)
				local node = state.tree:get_node()
				vim.cmd("silent execute '!xdg-open " .. node.path .. "'")
			end,
			-- Overwrite default `delete` commands to use trash instead of rm
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
		},
		window = {
			mappings = {}, -- See keymaps section below
		},
	},
	buffers = {
		follow_current_file = true,
		group_empty_dirs = true, -- when true, empty folders will be grouped together
		show_unloaded = true,
	},
	git_status = {
		window = {
			position = "float",
			mappings = {}, -- See keymaps section below
		},
	},
	event_handlers = {},
}
-- <== }

-- { == Events ==> ============================================================

local neo_tree_win = {
	id = -1,
	width = -1,
}

local barbar_ok, barbar_api = pcall(require, "barbar.api")

config.event_handlers = {
	{
		event = "neo_tree_window_after_open",
		handler = function(args) -- `h: neo-tree-window-event-args`
			if require("nxvim.plugins.windows").auto_maximize and vim.fn.win_gettype(args.winid) ~= "popup" then
				vim.api.nvim_win_set_width(args.winid, config.window.width)
			end
			neo_tree_win.id = args.winid
			neo_tree_win.width = vim.api.nvim_win_get_width(args.winid)
		end,
	},
	{
		event = "neo_tree_window_before_close",
		handler = function()
			if barbar_ok then barbar_api.set_offset(0) end
		end,
	},
	{
		event = "neo_tree_window_after_close",
		handler = function()
			if require("nxvim.plugins.windows").auto_maximize then vim.cmd("WindowsMaximize") end
			neo_tree_win.id = -1
		end,
	},
}

nx.au({
	{ -- Preserve size of neo-tree when using bufresize.nvim
		"VimResized",
		callback = function()
			if vim.api.nvim_win_is_valid(neo_tree_win.id) then
				vim.schedule(function() vim.api.nvim_win_set_width(neo_tree_win.id, neo_tree_win.width) end)
			end
		end,
	},
	{
		"DirChanged",
		callback = function()
			if vim.api.nvim_win_is_valid(neo_tree_win.id) then
				if not barbar_ok then return end
				barbar_api.set_offset(
					vim.api.nvim_win_get_width(neo_tree_win.id),
					"󰙅 " .. require("nxvim.utils").truc_path(vim.fn.getcwd())
				)
			end
		end,
	},
	{
		"WinResized",
		callback = function()
			if vim.api.nvim_win_is_valid(neo_tree_win.id) then
				neo_tree_win.width = vim.api.nvim_win_get_width(neo_tree_win.id)
				if not barbar_ok then return end
				barbar_api.set_offset(
					vim.api.nvim_win_get_width(neo_tree_win.id),
					"󰙅 " .. require("nxvim.utils").truc_path(vim.fn.getcwd())
				)
			end
		end,
	},
})
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
	["t"] = "open_tabnew",
	["w"] = "open_with_window_picker",
	["C"] = "close_node",
	["h"] = "close_node",
	["z"] = "close_all_nodes",
	["Z"] = "expand_all_nodes",
	["gp"] = "focus_preview",
	-- some commands like `add`, `copy`, `move` etc. can take config options, see `:h neo-tree-mappings` for details
	["a"] = "add",
	["A"] = "add_directory",
	["d"] = "delete",
	["<Del>"] = "delete",
	["r"] = "rename",
	["<F2>"] = "rename",
	["y"] = "copy_to_clipboard",
	["x"] = "cut_to_clipboard",
	["p"] = "paste_from_clipboard",
	["c"] = "copy",
	["m"] = "move",
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
	["#"] = "fuzzy_sorter",
	["f"] = "filter_on_submit",
	["<C-f>"] = "filter_on_submit",
	["<c-x>"] = "clear_filter",
	["[g"] = "prev_git_modified",
	["]g"] = "next_git_modified",
	["o"] = "system_open",
	["/"] = "none", -- use neovim default search
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
	-- stylua: ignore
	{ "<leader>,/", "<Cmd>Neotree float toggle dir=" .. vim.fn.stdpath("config") .. "<CR>", desc = "Config Files Tree" },
	{ "<leader>fe", "<Cmd>Neotree<CR>", desc = "Focus File Explorer" },
	{ "<leader>te", "<Cmd>NeoTreeShow<CR>", desc = "Toggle File Explorer", wk_label = "File Tree" },
	-- Addition shortcuts to view preset directories
	{ "<leader>f~", "<Cmd>Neotree float dir=$HOME<CR>", desc = "Browse Home Dir" },
	-- stylua: ignore
	{ "<leader>,\\", "<Cmd>Neotree float dir=" .. vim.fn.stdpath("data") .. "<CR>", desc = "Browse Data Dir", wk_label = "ignore" },
	{ "<leader>,.", "<Cmd>Neotree float dir=$HOME/.config<CR>", desc = "Browse Dotfiles", wk_label = "ignore" },
})

nx.au({
	"FileType",
	pattern = "neo-tree-popup",
	callback = function()
		vim.schedule(function()
			nx.map({
				{ "q", "<Cmd>q!<CR>" },
				{ "<C-c>", "<Cmd>q!<CR>" },
				{ "<Esc>", "<Esc>", "i" },
				-- stylua: ignore
				{ "<C-j>", function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, false, true), "i", false) end, "i" },
				-- stylua: ignore
				{ "<C-k>", function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, false, true), "i", false) end, "i" },
			}, { buffer = 0 })
		end)
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
			{ "NeoTreeTabActive", fg = colors.tree_file_name },
			{ "NeoTreeTabInactive", fg = "NeoTreeDimText:fg", bg = "DraculaBgDark:bg" },
			{ "NeoTreeTabSeparatorInactive", bg = "DraculaBgDark:bg", fg = "DraculaBgDarker:bg" },
		})

		if vim.env.TERM_PROGRAM == "WezTerm" then
			nx.hl({ -- remove italics due to oversized icons in wezterm
				{ "NeoTreeGitConflict", fg = "NeoTreeGitConflict:fg" },
				{ "NeoTreeGitUntracked", fg = "NeoTreeGitUntracked:fg" },
			})
		end
	end

	if vim.g.colors_name == "tokyonight" then
		nx.hl({
			{ "NeoTreeTabActive", link = "NeoTreeNormal" },
			{ "NeoTreeTabInactive", fg = "NeoTreeDimText:fg", bg = "TabLine:bg" },
			{ "NeoTreeTabSeparatorInactive", fg = "TabLine:bg", bg = "TabLine:bg" },
		})
	end
end

set_hls()
nx.au({ "Colorscheme", callback = set_hls })
-- <== }
