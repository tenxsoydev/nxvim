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
		fold_closed = "",
		fold_open = "",
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

local actions = require("diffview.actions")

config.key_bindings = {
	disable_defaults = false,
	file_panel = {
		{ "n", "s", actions.toggle_stage_entry, { desc = "Stage / unstage the selected entry." } },
		{ "n", "<c-f>", actions.scroll_view(0.382), { desc = "Scroll the view down" } },
		{ "n", "<c-b>", actions.scroll_view(-0.382), { desc = "Scroll the view up" } },
	},
}

nx.map({
	{ "<leader>gd", "<Cmd>DiffviewToggle<CR>", desc = "Toggle Diffview", wk_label = "Diffview" },
	{ "<leader>gh", "<Cmd>DiffviewFileHistory %<CR>", desc = "Diffview File History", wk_label = "File History" },
})
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
		{ "diffChanged", link = "DiffviewDim1" }, -- there is no `diffChanged` in official dracula
	})
end
-- <== }

-- { == Commands ==> ==========================================================

nx.cmd({
	"DiffviewToggle",
	function(e)
		local view = require("diffview.lib").get_current_view()
		if view then
			vim.cmd("DiffviewClose")
		else
			vim.cmd("DiffviewOpen " .. e.args)
		end
	end,
	nargs = "*",
})
-- <== }
