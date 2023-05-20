-- https://github.com/glepnir/galaxyline.nvim/tree/main/lua

local gl = require("galaxyline")

-- { == Colors ==> ============================================================

local colors = require("galaxyline.theme").default

if vim.g.colors_name == "tokyonight" then
	local palette = require("tokyonight.colors").setup()
	colors = {
		fg = palette.fg_dark,
		bg = palette.bg_highlight,
		darkblue = palette.bg_dark,
		cyan = palette.cyan,
		green = palette.green,
		yellow = palette.blue,
		orange = palette.orange,
		violet = palette.purple,
		magenta = palette.magenta,
		blue = palette.blue,
		red = palette.red,
	}
end

if vim.g.colors_name == "dracula" then
	local palette = require("nxvim.colorschemes.dracula").palette
	colors = {
		fg = "#9dacb9",
		bg = palette.bglight,
		darkblue = palette.bgdark,
		cyan = palette.cyan,
		green = palette.green,
		yellow = palette.yellow,
		orange = palette.orange,
		violet = palette.purple,
		magenta = palette.purple,
		blue = palette.comment,
		red = palette.red,
	}

	-- set color of little parts of the statusline next to defined modules below
	nx.hl({ "StatusLine", bg = colors.bg })
end
-- <== }

-- { == Sections ==> ==========================================================

local diagnostic = require("galaxyline.provider_diagnostic")

local conditions = {
	gl = require("galaxyline.condition"),
	has_file_type = function()
		if not vim.bo.filetype or vim.bo.filetype == "" then return false end
		return true
	end,
	---@param win_width? number
	break_width = function(win_width)
		win_width = win_width or 50
		if vim.fn.winwidth(0) / 2 > win_width then return true end
		return false
	end,
}

local format_icons = { dos = "", mac = "", unix = "" }

-- Seperators
-- pixels { big = {    }, small = {   } }

gl.section.left = {
	-- Mode ----------------------------------------------------------------------
	{
		ModeStartSep = {
			provider = function() end,
			-- separator = " ",
			separator = " ",
			separator_highlight = { colors.darkblue, colors.bg },
		},
	},
	{
		ViMode = {
			icon = function()
				local icons = {
					n = "󰆾 ",
					i = " ",
					c = "󰞷 ",
					v = "󰆿 ",
					V = "󰆿 ",
					[""] = "󰆿 ",
					C = "󰞷 ",
					R = "󰛔 ",
					t = " ",
				}
				return icons[vim.fn.mode()]
			end,
			provider = function()
				-- auto change color according the vim mode
				local alias = {
					n = "N ",
					i = "I ",
					c = "C ",
					V = "VL",
					[""] = "VB",
					v = "V ",
					C = "C ",
					["r?"] = ":CONFIRM",
					rm = "--MORE",
					R = "R ",
					Rv = "RV",
					s = "S ",
					S = "S ",
					["r"] = "HIT-ENTER",
					[""] = "SELECT",
					t = "T ",
					["!"] = "SH",
				}
				local mode_color = {
					n = colors.cyan,
					i = colors.red,
					v = colors.yellow,
					[""] = colors.yellow,
					V = colors.yellow,
					c = colors.magenta,
					no = colors.red,
					s = colors.orange,
					S = colors.orange,
					[""] = colors.orange,
					ic = colors.yellow,
					R = colors.blue,
					Rv = colors.blue,
					cv = colors.red,
					ce = colors.red,
					r = colors.cyan,
					rm = colors.cyan,
					["r?"] = colors.cyan,
					["!"] = colors.red,
					t = colors.red,
				}
				local vim_mode = vim.fn.mode()
				vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim_mode])
				return alias[vim_mode]
			end,
			highlight = { colors.darkblue, colors.bg },
			separator = " ",
			separator_highlight = { colors.darkblue, colors.bg },
		},
	},
	{
		ModeEndSep = {
			provider = function() end,
			separator = "",
			separator_highlight = { colors.bg },
		},
	},

	-- Git -----------------------------------------------------------------------
	{
		GitStartSep = {
			provider = function() end,
			separator = " ",
			separator_highlight = { colors.darkblue },
		},
	},
	{
		GitIcon = {
			provider = function() return "  " end,
			condition = conditions.gl.check_git_workspace,
			highlight = { colors.orange, colors.darkblue },
		},
	},
	{
		GitBranch = {
			provider = "GitBranch",
			highlight = { colors.fg, colors.darkblue },
			condition = conditions.gl.check_git_workspace,
			separator = " ",
			separator_highlight = { colors.darkblue, colors.darkblue },
		},
	},
	{
		DiffAdd = {
			provider = "DiffAdd",
			icon = " ",
			condition = conditions.break_width,
			highlight = { colors.green, colors.darkblue },
		},
	},
	{
		DiffModified = {
			provider = "DiffModified",
			icon = "  ",
			condition = conditions.break_width,
			highlight = { colors.orange, colors.darkblue },
		},
	},
	{
		DiffRemove = {
			provider = "DiffRemove",
			icon = "  ",
			condition = conditions.break_width,
			highlight = { colors.red, colors.darkblue },
		},
	},
	{
		DiffEndSep = {
			provider = function() end,
			separator = "",
			separator_highlight = { colors.bg, colors.darkblue },
		},
	},
	{
		Space = {
			provider = function() return " " end,
			highlight = { colors.bg, colors.bg },
		},
	},

	-- File ----------------------------------------------------------------------
	{
		FileIcon = {
			provider = "FileIcon",
			condition = function()
				if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then return true end
				return false
			end,
			highlight = {
				require("galaxyline.provider_fileinfo").get_file_icon_color,
				colors.bg,
			},
		},
	},
	{
		BufferType = {
			-- provider = "FilePath",
			provider = "FileName",
			condition = conditions.has_file_type,
			highlight = { colors.fg, colors.bg },
		},
	},

	-- Diagnostics ---------------------------------------------------------------
	{
		DiagnosticError = {
			provider = diagnostic.get_diagnostic_error,
			icon = "  ",
			highlight = { colors.red, colors.bg },
		},
	},
	{
		DiagnosticWarn = {
			provider = diagnostic.get_diagnostic_warn,
			condition = function() return conditions.break_width(55) end,
			icon = "  ",
			highlight = { colors.yellow, colors.bg },
		},
	},
	{
		DiagnosticInfo = {
			provider = diagnostic.get_diagnostic_info,
			condition = function() return conditions.break_width(55) end,
			highlight = { colors.green, colors.bg },
			icon = "  ",
		},
	},
	{
		DiagnosticHint = {
			provider = diagnostic.get_diagnostic_hint,
			condition = function() return conditions.break_width(55) end,
			highlight = { colors.blue, colors.bg },
			icon = " 󰌵 ",
		},
	},
	{
		DarkSepara = {
			provider = function() return "" end,
			highlight = { colors.bg },
		},
	},
}

gl.section.right = {
	-- LSP Client ----------------------------------------------------------------
	{
		LspStartSep = {
			provider = function() return "  " end,
			highlight = { colors.yellow, colors.bg },
			separator = "",
			separator_highlight = { colors.bg },
		},
	},
	{
		GetLspClient = {
			provider = "GetLspClient",
			condition = function() return conditions.break_width(35) end,
			highlight = { colors.fg, colors.bg },
		},
	},
	{
		LspEndSep = {
			provider = function() return "" end,
			highlight = { colors.bg, colors.darkblue },
			separator = " ",
			separator_highlight = { colors.bg, colors.bg },
		},
	},

	-- Position ------------------------------------------------------------------
	{
		LineInfo = {
			provider = "LineColumn",
			condition = conditions.break_width,
			highlight = { colors.fg, colors.darkblue },
			separator = "   ",
			separator_highlight = { colors.yellow, colors.darkblue },
		},
	},
	{
		ScrollBar = {
			provider = "ScrollBar",
			highlight = { colors.violet, colors.darkblue },
			separator = " ",
			separator_highlight = { colors.blue, colors.darkblue },
		},
	},
	{
		Percent = {
			provider = "LinePercent",
			highlight = { colors.fg, colors.darkblue },
			separator = " ", -- " ", --     󰞁 󰆌
			separator_highlight = { colors.blue, colors.darkblue },
		},
	},

	-- Indentation ---------------------------------------------------------------
	{
		Indentation = {
			provider = function()
				local indentation_type = "Tabs:"
				if vim.api.nvim_buf_get_option(0, "expandtab") then indentation_type = "Spaces:" end
				return indentation_type .. vim.o.ts
			end,
			condition = conditions.break_width,
			highlight = { colors.fg, colors.darkblue },
			separator = "  ",
			separator_highlight = { colors.yellow, colors.darkblue },
		},
	},

	-- File Format ---------------------------------------------------------------
	{
		FileFormat = {
			provider = function()
				local fileFormat = string.upper(vim.bo.fileencoding)
				return fileFormat
			end,
			condition = function() return conditions.break_width(55) end,
			highlight = { colors.fg, colors.darkblue },
			-- separator = " ",
			separator = "  " .. format_icons[vim.bo.fileformat] .. " ",
			separator_highlight = { colors.yellow, colors.darkblue },
		},
	},

	{
		RightSpace = {
			provider = function() return " " end,
			highlight = { colors.darkblue, colors.darkblue },
		},
	},
}

gl.short_line_list = {
	"alpha",
	"LuaTree",
	"vista",
	"dbui",
	"startify",
	"term",
	"nerdtree",
	"fugitive",
	"fugitiveblame",
	"plug",
	"NvimTree",
	"neo-tree",
	"DiffviewFiles",
	"Outline",
	"neoterm",
	"fern",
	"toggleterm",
	"filetree",
	"explorer",
}

local BufferTypeMap = {
	["alpha"] = "󰍂 Alpha",
	["Mundo"] = "Mundo History",
	["MundoDiff"] = "Mundo Diff",
	["NvimTree"] = " Tree",
	["neo-tree"] = " Tree",
	["fugitive"] = " Fugitive",
	["fugitiveblame"] = " Fugitive Blame",
	["help"] = "󰋗 Help",
	["minimap"] = "Minimap",
	["qf"] = "󰁨 Quick Fix",
	["tabman"] = "Tab Manager",
	["tagbar"] = "Tagbar",
	["FTerm"] = "Terminal",
	["neoterm"] = " NeoTerm",
	["toggleterm"] = " ToggleTerm",
	["git"] = " Git",
	["NeogitStatus"] = " Neogit Status",
	["NeogitPopup"] = " Neogit Popup",
	["NeogitCommitMessage"] = "󰍣 Neogit Commit",
	["DiffviewFiles"] = " Diff View",
	["dapui_scopes"] = "󱁯 Dap Scope",
	["dapui_breakpoints"] = " Dap Breakpoints",
	["dapui_stacks"] = " Dap Stacks",
	["dapui_watches"] = "󰙔 Dap Watch",
	["dap-repl"] = " Dap REPL",
	["Outline"] = " SymbolOutline",
	["fern"] = " Fern FM",
	["filetree"] = " Tree",
}

gl.section.short_line_left = {
	{
		ShortLineBlankSpace = {
			provider = function() return " " end,
			highlight = { colors.bg, colors.bg },
		},
	},
	{
		ShortLineLeftBufferName = {
			provider = "FileName",
			condition = function()
				if BufferTypeMap[vim.bo.filetype] then return false end
				return true
			end,
			highlight = { colors.fg, colors.bg },
		},
	},
	{
		ShortLineLeftBufferType = {
			provider = function()
				-- local file_name = vim.fn.expand("%:t")
				if vim.bo.filetype == "neo-tree" then return " 󰙅 Neo-tree " end
				local mapped_name = BufferTypeMap[vim.bo.filetype]
				if mapped_name then return " " .. mapped_name .. " " end
			end,
			condition = conditions.has_file_type,
			highlight = { colors.fg, colors.bg },
			separator = " ",
			separator_highlight = { colors.bg, colors.darkblue },
		},
	},
	{
		ShortLineLeftWindowNumber = {
			provider = function() return vim.api.nvim_win_get_number(vim.api.nvim_get_current_win()) .. " " end,
			icon = " ",
			highlight = { colors.blue, colors.darkblue },
			separator = "",
			separator_highlight = { colors.darkblue, "colors.black" },
		},
	},
}

-- { == Load Setup ==> ========================================================

gl.galaxyline_augroup()
-- <== }

-- { == Events ==> ============================================================

-- We run into some issues with tint. Toggling it off/on apparently fixes them, while refreshing does not
local tint_ok, tint = pcall(require, "tint")

local function pseudo_toggle_tint()
	if tint_ok then
		tint.toggle()
		tint.toggle()
	end
end
pseudo_toggle_tint()

local timer = vim.loop.new_timer()

nx.au({
	"WinEnter",
	callback = function()
		if vim.fn.win_gettype(0) == "popup" then
			timer:stop()
			return
		end

		timer:stop()
		timer:start(350, 0, vim.schedule_wrap(pseudo_toggle_tint))
	end,
	{
		"WinResized",
		callback = function()
			if vim.fn.win_gettype(0) ~= "popup" then gl.load_galaxyline() end
		end,
	},
})
-- <== }
