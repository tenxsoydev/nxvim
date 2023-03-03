local spectre = require("spectre")

local config = {
	mapping = {},
	line_sep_start = "╭─────────────────────────────────────────",
	line_sep = "╰─────────────────────────────────────────",
	result_padding = "│  ",
}

-- Keymaps ===================================================================

config.mapping = {
	["toggle_line"] = {
		map = "t",
		cmd = "<Cmd>lua require('spectre').toggle_line()<CR>",
		desc = "toggle current item",
	},
	["enter_file"] = {
		map = "<cr>",
		cmd = "<Cmd>lua require('spectre.actions').select_entry()<CR>",
		desc = "goto current file",
	},
	["send_to_qf"] = {
		map = "Q",
		cmd = "<Cmd>lua require('spectre.actions').send_to_qf()<CR>",
		desc = "send all item to quickfix",
	},
	["replace_cmd"] = {
		map = "c",
		cmd = "<Cmd>lua require('spectre.actions').replace_cmd()<CR>",
		desc = "input replace vim command",
	},
	["show_option_menu"] = {
		map = "o",
		cmd = "<Cmd>lua require('spectre').show_options()<CR>",
		desc = "show option",
	},
	["run_replace"] = {
		map = "R",
		cmd = "<Cmd>lua require('spectre.actions').run_replace()<CR>",
		desc = "replace all",
	},
	["change_view_mode"] = {
		map = "m",
		cmd = "<Cmd>lua require('spectre').change_view()<CR>",
		desc = "change result view mode",
	},
	["toggle_ignore_case"] = {
		map = "I",
		cmd = "<Cmd>lua require('spectre').change_options('ignore-case')<CR>",
		desc = "toggle ignore case",
	},
	["toggle_ignore_hidden"] = {
		map = "H",
		cmd = "<Cmd>lua require('spectre').change_options('hidden')<CR>",
		desc = "toggle search hidden",
	},
	-- you can put your mapping here it only use normal mode
}

nx.map({
	{ "<leader>rb", function() spectre.open_file_search() end, desc = "In Active Buffer" },
	{ "<leader>rr", spectre.open, desc = "In Workspace" },
	{ "<leader>rw", function() spectre.open_visual({ select_word = true }) end, desc = "Word Under Cursor" },
	{ "<leader>r", "<Esc><Cmd>lua require('spectre').open_visual()<CR>", "v", desc = "Replace" },
})

require("spectre").setup(config)
