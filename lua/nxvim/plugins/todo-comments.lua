-- https://github.com/folke/todo-comments.nvim

-- { == Configuration ==> =====================================================

require("todo-comments").setup({
	signs = true, -- show icons in the signs column
	sign_priority = 8, -- sign priority
	-- keywords recognized as todo comments
	keywords = {
		FIX = {
			icon = " ", -- icon used for the sign, and in search results
			color = "error", -- can be a hex color, or a named color (see below)
			alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
			-- signs = false, -- configure signs for some keywords individually
		},
		TODO = { icon = " ", color = "info", alt = { "#to/do" } },
		HACK = { icon = " ", color = "warning" },
		WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
		PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
		TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
	},
	gui_style = {
		fg = "NONE", -- The gui style to use for the fg highlight group.
		bg = "BOLD", -- The gui style to use for the bg highlight group.
	},
	merge_keywords = true, -- when true, custom keywords will be merged with the defaults
	-- highlighting of the line containing the todo comment
	-- * before: highlights before the keyword (typically comment characters)
	-- * keyword: highlights of the keyword
	-- * after: highlights after the keyword (todo text)
	highlight = {
		multiline = false, -- enable multine todo comments
		multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
		multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
		before = "", -- "fg" or "bg" or empty
		keyword = "wide_fg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
		after = "", -- "fg" or "bg" or empty
		pattern = [[.*<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlightng (vim regex)
		comments_only = true, -- uses treesitter to match keywords in comments only
		max_line_len = 400, -- ignore lines longer than this
		exclude = {}, -- list of file types to exclude highlighting
	},
	-- list of named colors where we try to extract the guifg from the
	-- list of highlight groups or use the hex color if hl not found as a fallback
	colors = {
		error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
		warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
		info = { "DiagnosticInfo", "#2563EB" },
		hint = { "DiagnosticHint", "#10B981" },
		default = { "Identifier", "#7C3AED" },
		test = { "Identifier", "#FF00FF" },
	},
	search = {
		command = "rg",
		args = {
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
		},
		-- regex that will be used to match keywords.
		-- don't replace the (KEYWORDS) placeholder
		pattern = [[\b(KEYWORDS):]], -- ripgrep regex
		-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
	},
})
-- <== }

-- { == Commands ==> ==========================================================

local function toggle()
	local hl_status = require("todo-comments.highlight")
	local action

	if hl_status.enabled then
		hl_status.stop()
		action = "disabled"
	else
		hl_status.start()
		action = "enabled"
	end
	vim.notify("Todo Comments: highlighting " .. action)
end

nx.cmd({
	"TodoHlToggle",
	function() toggle() end,
	desc = "Toggle Highlight Comments Highlighting",
})
-- <== }

-- { == Keymaps ==> ===========================================================

nx.map({
	{ "<leader>/c", "<Cmd>TodoTelescope<CR>", desc = "Search Todo Comments", wk_label = "Todo Comments" },
	{ "<leader>c/", "<Cmd>TodoTelescope<CR>", desc = "Search Todo Comments", wk_label = "Search" },
	{ "<leader>ct", "<Cmd>TodoHlToggle<CR>", desc = "Toggle Comment Highlighting", wk_label = "Toggle Highlighting" },
	{ "<leader>cl", "<Cmd>TodoLocList<CR>", desc = "List Comment Highlights", wk_label = "List" },
	{ "<leader>cq", "<Cmd>TodoQuickFix<CR>", desc = "List Comment Highlights" },
	-- {"<leader>hq", "<Cmd>TodoTrouble<CR>",  desc = "Open Comment Highlights in Trouble" },
})
-- <== }

-- { == Highlights ==> ========================================================

-- Disable nvim inbuilt Todo highlighting as plugins highlights are used
nx.hl({ "Todo", link = "Comment" })
-- <== }
