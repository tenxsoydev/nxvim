local M = {}

local helper = require("windline.helpers")
local b_components = require("windline.components.basic")
---@diagnostic disable-next-line: undefined-field
local state = _G.WindLine.state

local lsp_comps = require("windline.components.lsp")
local git_comps = require("windline.components.git")

local breakpoint_width = 90

local hl_list = {
	Black = { "white", "black" },
	White = { "black", "white" },
	Inactive = { "InactiveFg", "InactiveBg" },
	Active = { "ActiveFg", "ActiveBg" },
	Filename = { "FilenameFg", "black" },
	Path = { "StatusLinePath", "black" },
}

local basic = {}
basic.divider = { b_components.divider, hl_list.Black }
basic.divider_inactive = { b_components.divider, hl_list.Inactive }
basic.bg = { " ", "StatusLine" }

-- { LEFT PANEL
local colors_mode = {
	Normal = { "cyan_light", "black" },
	Insert = { "red_light", "black" },
	Visual = { "green_light", "black" },
	Replace = { "yellow_light", "black" },
	Command = { "magenta_light", "black" },
}

local function indicator()
	local indicators = {
		n = " N ",
		i = " I ",
		c = "ﲵ C ",
		v = " V ",
		V = " VL",
		[""] = " VB",
		C = "ﲵ C ",
		R = "﯒ R ",
		r = "﯒ R ",
		t = " T ",
	}
	return tostring(indicators[vim.fn.mode()])
end

basic.square_mode = {
	hl_colors = colors_mode,
	text = function() return { { "▊", state.mode[2] } } end,
}

basic.vi_mode = {
	name = "vi_mode",
	hl_colors = colors_mode,
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
			{ git_comps.diff_changed({ format = " 柳%s", show_zero = false }), "blue" },
		}
	end,
}

local icon_comp = b_components.cache_file_icon({ default = "", hl_colors = hl_list.Black })

basic.file = {
	hl_colors = {
		default = hl_list.Filename,
		path = hl_list.Path,
		inactive = hl_list.Inactive,
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
		default = hl_list.Inactive,
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
basic.lsp_name = {
	name = "lsp_name",
	width = breakpoint_width,
	hl_colors = {
		cyan = { "cyan_light", "black" },
	},
	text = function(bufnr)
		if lsp_comps.check_lsp(bufnr) then
			return {
				{ " " },
				-- add emtpy table to not use default of hiding null-ls
				{ lsp_comps.lsp_name({ hide_server_names = {} }), "cyan" },
			}
		end
		return {
			{ "idle" },
		}
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
			{ lsp_comps.lsp_hint({ format = "  %s", show_zero = false }), "blue" },
		}
	end,
}

basic.position = {
	text = function()
		return {
			-- { " ", hl_list.Filename }, -- " "
			{ b_components.line_col, hl_list.Filename },
			{ b_components.progress, hl_list.Filename },
			{ " " },
		}
	end,
}

basic.position_inactive = {
	text = function()
		return {
			{ b_components.line_col, hl_list.Inactive },
			{ b_components.progress, hl_list.Inactive },
			{ " " },
		}
	end,
}

local function get_indentation(bufnr)
	local indentation_type = "Tabs:"
	if vim.api.nvim_buf_get_option(bufnr, "expandtab") then indentation_type = "Spaces:" end
	return indentation_type
end

basic.file_info = {
	width = 75,
	text = function(bufnr)
		return {
			-- { "ﲒ", hl_list.Filename },
			{ " " },
			{ get_indentation(bufnr), hl_list.Filename },
			{ vim.o.ts, hl_list.Filename },
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
		{ "Quickfix ", hl_list.Filename },
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
		{ " Diffview ", hl_list.Filename },
		{ b_components.divider },
	},
	always_active = true,
	show_last_status = true,
}

M.dashboard = {
	filetypes = { "alpha", "dashboard" },
	active = {
		{ "▊", { "black_light", "black" } },
		{ "  ", { "green", "black" } },
		{ " Dashboard ", hl_list.Filename },
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
		{ b_components.cache_file_type({ icon = true }), hl_list.Filename },
		{ b_components.divider },
	},
	inactive = {
		{ "▊", { "black_light", "black" } },
		{ "  ", hl_list.Filename }, --  
		{ "  " },
		{ b_components.cache_file_type({ icon = true }), hl_list.Filename },
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
		basic.divider,
		basic.lsp_diagnos,
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
