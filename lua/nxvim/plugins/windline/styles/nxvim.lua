local M = {}

local helper = require("windline.helpers")
local b_components = require("windline.components.basic")
---@diagnostic disable-next-line: undefined-field
local state = _G.WindLine.state

local lsp_comps = require("windline.components.lsp")
local git_comps = require("windline.components.git")
local highlighter = require("vim.treesitter.highlighter")

local breakpoint_width = 90

local colors = {
	black = { "white", "black" },
	white = { "black", "white" },
	inactive = { "InactiveFg", "InactiveBg" },
	active = { "ActiveFg", "ActiveBg" },
	filename = { "FilenameFg", "black" },
	path = { "StatusLinePath", "black" },
	cyan = { "cyan_light", "black" },
}

local basic = {}
basic.divider = { b_components.divider, colors.black }
basic.divider_inactive = { b_components.divider, colors.inactive }
basic.bg = { " ", "StatusLine" }

-- { LEFT PANEL
local mode_colors = {
	Normal = colors.cyan,
	Insert = { "red_light", "black" },
	Visual = { "green_light", "black" },
	Replace = { "yellow_light", "black" },
	Command = { "magenta_light", "black" },
}

local function indicator()
	local indicators = {
		n = "󰆾 N ",
		i = " I ",
		c = "󰞷 C ",
		v = "󰆿 V ",
		V = "󰆿 VL",
		[""] = "󰆿 VB",
		C = "󰞷 C ",
		R = "󰛔 R ",
		r = "󰛔 R ",
		t = " T ",
	}
	return tostring(indicators[vim.fn.mode()])
end

basic.square_mode = {
	hl_colors = mode_colors,
	text = function() return { { "▊", state.mode[2] } } end,
}

basic.vi_mode = {
	name = "vi_mode",
	hl_colors = mode_colors,
	text = function()
		return {
			{ " " },
			{ indicator, state.mode[2] },
			{ " " },
		}
	end,
}

basic.git_branch = { git_comps.git_branch(), { "cyan", "black" }, 70 }

basic.git_diffs = {
	width = 60,
	hl_colors = {
		green = { "green", "black" },
		red = { "red", "black" },
		blue = { "blue", "black" },
	},
	text = function(bufnr)
		if not git_comps.is_git(bufnr) then return end

		return {
			{ git_comps.diff_added({ format = "  %s", show_zero = false }), "green" }, -- show_zero = ture == default
			{ git_comps.diff_removed({ format = "  %s", show_zero = false }), "red" },
			{ git_comps.diff_changed({ format = "  %s", show_zero = false }), "blue" },
		}
	end,
}

local icon_comp = b_components.cache_file_icon({ default = "", hl_colors = colors.black })

basic.file = {
	hl_colors = {
		default = colors.filename,
		path = colors.path,
	},
	text = function(bufnr)
		return {
			{ "  " },
			icon_comp(bufnr),
			{ " " },
			-- { require("nxvim.utils").truc_path(vim.fn.getcwd()) .. "/", "path" },
			{ b_components.cache_file_name("[No Name]", "unique"), "default" },
			{ b_components.file_modified(" ", true), "default" },
		}
	end,
}

basic.file_inactive = {
	hl_colors = {
		default = colors.inactive,
	},
	text = function()
		return {
			{ " ", "default" },
			-- { '  ', 'default' },
			-- { vim.api.nvim_win_get_number(0) },
			{ b_components.cache_file_name("[No Name]", "unique"), "default" },
			{ b_components.file_modified(" ", true), "default" },
		}
	end,
}
-- }

-- { RIGHT PANEL
basic.treesitter = {
	name = "treesitter",
	width = breakpoint_width,
	text = function(bufnr)
		-- Highlight cogwheel when TS is active.
		return {
			{ " ", highlighter.active[bufnr] and colors.cyan or colors.filename },
		}
	end,
}

basic.lsp_name = {
	name = "lsp_name",
	width = breakpoint_width,
	hl_colors = {
		cyan = { "cyan_light", "black" },
	},
	text = function(bufnr)
		-- Don't hide null-ls.
		-- TODO: Display null-ls names?
		local lsp_names = lsp_comps.check_lsp(bufnr)
				and { lsp_comps.lsp_name({ hide_server_names = {}, icon = "" }), "cyan" }
			or { "idle", colors.filename }
		return { lsp_names }
	end,
}

basic.lsp_diagnos = {
	name = "diagnostics",
	hl_colors = {
		red = { "red", "black" },
		yellow = { "yellow", "black" },
		blue = { "blue", "black" },
	},
	text = function(bufnr)
		if not lsp_comps.check_lsp(bufnr) then return end

		return {
			{ lsp_comps.lsp_error({ format = "  %s", show_zero = false }), "red" },
			{ lsp_comps.lsp_warning({ format = "  %s", show_zero = false }), "yellow" },
			{ lsp_comps.lsp_hint({ format = " 󰋼 %s", show_zero = false }), "blue" },
		}
	end,
}

basic.position = {
	text = function()
		return {
			-- { " ", hl_list.Filename }, -- " 󰉶"
			{ b_components.line_col, colors.filename },
			{ b_components.progress, colors.filename },
			{ " " },
		}
	end,
}

basic.position_inactive = {
	text = function()
		return {
			{ b_components.line_col, colors.inactive },
			{ b_components.progress, colors.inactive },
			{ " " },
		}
	end,
}

local function get_indentation(bufnr)
	local indentation_type = "Tabs:"
	if vim.bo[bufnr].expandtab then indentation_type = "Spaces:" end
	return indentation_type
end

basic.file_info = {
	width = 75,
	text = function(bufnr)
		return {
			-- { "󰞔", hl_list.Filename },
			{ " " },
			{ get_indentation(bufnr), colors.filename },
			{ vim.o.ts, colors.filename },
			{ "  " },
			{ b_components.file_encoding() },
			{ " " },
		}
	end,
}
-- }

M.quickfix = {
	filetypes = { "qf", "Trouble" },
	active = {
		{ "▊", { "black_light", "black" } },
		{ "  ", { "green", "black" } }, -- 
		{ "Quickfix ", colors.filename },
		-- { helper.separators.slant_right, { 'black', 'black_light' } },
		{ function() return vim.fn.getqflist({ title = 0 }).title end, { "green", "black" } },
		{ " %L ", { "green", "black" } },
		-- { helper.separators.slant_right, { 'black_light', 'InactiveBg' } },
		{ " ", { "InactiveFg", "InactiveBg" } },
		basic.divider,
		{ helper.separators.slant_right, { "InactiveBg", "black" } },
	},

	always_active = true,
	show_last_status = true,
}

M.explorer = {
	filetypes = { "fern", "NvimTree", "lir", "filetree", "neo-tree" },
	active = {
		{ "▊", { "black_light", "black" } },
		{ " 󰙅 Neo-tree", { "blue", "black" } },
		{ b_components.divider },
	},
	always_active = true,
	show_last_status = true,
}

M.diffview = {
	filetypes = { "DiffviewFiles" },
	active = {
		{ "▊", { "black_light", "black" } },
		{ "  ", { "green", "black" } },
		{ " Diffview ", colors.filename },
		{ b_components.divider },
	},
	always_active = true,
	show_last_status = true,
}

M.dashboard = {
	filetypes = { "alpha", "dashboard" },
	active = {
		{ "▊", { "black_light", "black" } },
		{ " 󰍂 ", { "green", "black" } },
		{ " Dashboard ", colors.filename },
		-- { ' ', '' }, { b_components.cache_file_type({ icon = true }), hl_list.Filename },
		{ b_components.divider },
	},
	always_active = true,
	show_last_status = true,
}

M.terminal = {
	filetypes = { "FTerm", "neoterm", "toggleterm" },
	hl_colors = { "black_light", "black" },
	active = {
		{ "▊", { "black_light", "black" } },
		{ " " },
		{ indicator, { "green", "black" } },
		{ "  " },
		{ b_components.cache_file_type({ icon = true }), colors.filename },
		{ b_components.divider },
	},
	inactive = {
		{ "▊", { "black_light", "black" } },
		{ " " },
		{ indicator, colors.filename }, --  󰅪
		{ "  " },
		{ b_components.cache_file_type({ icon = true }), colors.filename },
		{ b_components.divider },
	},
	always_active = false,
	show_last_status = true,
}

M.default = {
	filetypes = { "default" },
	active = {
		basic.square_mode,
		basic.vi_mode,
		basic.git_branch,
		basic.git_diffs,
		basic.file,
		basic.lsp_diagnos,
		basic.divider,
		basic.treesitter,
		basic.lsp_name,
		basic.position,
		basic.file_info,
		basic.square_mode,
	},
	inactive = {
		basic.file_inactive,
		basic.divider_inactive,
		basic.position_inactive,
	},
}

return M
