-- https://github.com/glepnir/lspsaga.nvim/blob/main/plugin/lspsaga.lua

local M = {}

local config = {
	ui = {
		border = nx.opts.float_win_border,
		code_action = "",
		kind = {
			Folder = { "", "" },
		},
	},
	lightbulb = {
		enable = true,
		enable_in_insert = true,
		sign = true,
		sign_priority = 40,
		virtual_text = false,
	},
	rename = {
		-- after all we'll use default lsp_rename with dressing
		in_select = false,
	},
	finder = {
		keys = {}, -- See keymaps section below
	},
	outline = {
		keys = {},
	},
	callhierarchy = {
		keys = {},
	},
	symbol_in_winbar = {
		enable = true,
		separator = " › ",
		hide_keyword = true,
		show_file = true,
		folder_level = 3,
		respect_root = false,
	},
}

-- { == Keymaps ==> ===========================================================

config.finder.keys = {
	expand_or_jump = "<CR>",
	quit = { "q", "<C-c>", "<C-h>", "<C-j>", "<C-k>", "<C-l>" },
}
config.outline.keys = {
	expand_or_jump = "<CR>",
}
config.callhierarchy.keys = {
	jump = "<CR>",
}

---@param bufnr number
function M.on_attach(_, bufnr)
	nx.map({
		-- { "K", "<Cmd>Lspsaga hover_doc<CR>", desc = "LSP Hover" },
		{ "gp", "<Cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
		{ "gd", "<cmd>Lspsaga goto_definition<CR>" },
		{ "gr", "<Cmd>Lspsaga lsp_finder<CR>", desc = "Show References" },
		-- { "<leader>gl", "<cmd>Lspsaga show_line_diagnostics<CR>" },
		-- { "<leader>gL", "<cmd>Lspsaga show_cursor_diagnostics<CR>" },
		-- Use default vim.lsp.buf.rename() with dressing for now
		-- { "<F2>", "<Cmd>Lspsaga rename<CR>", { "i", "n" }, desc = "Rename" },
		{ "<F12>", "<Cmd>Lspsaga lsp_finder<CR>", desc = "Show References" },
		{ "<leader>lr", "<Cmd>Lspsaga lsp_finder<CR>", desc = "Show References" },
		{ "<leader>ld", "<Cmd>Lspsaga peek_definition<CR>", desc = "Peek definition" },
		{ "<leader>lo", "<Cmd>Lspsaga outline<CR>", desc = "Toggle Symbols Outline" },
		{ "<leader>to", "<Cmd>Lspsaga outline<CR>", desc = "Toggle Symbols Outline", wk_label = "Outline Symbols" },
		{ "<leader>dj", "<Cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostic" },
		{ "<leader>dk", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Previous Diagnostic" },
		{ "<leader>la", "<Cmd>Lspsaga code_action<CR>", desc = "Code Action" },
		{ { "<C-.>", "<A-.>" }, "<Cmd>Lspsaga code_action<CR>", desc = "Code Action" }, -- <C-.> works in kitty and GUIs
	}, { buffer = bufnr })
end

-- <== }

-- { == Load Setup ==> ========================================================

require("lspsaga").setup(config)
-- <== }

-- { == Highlights ==> ========================================================

function M.set_hl()
	nx.hl({
		{ "SagaBorder", link = "FloatBorder" },
		{ { "SagaWinbarSep", "SagaWinbarFolder", "SagaWinbarFolderName" }, link = "Winbar" },
	})

	if vim.g.colors_name == "dracula" then
		local palette = require("nxvim.colorschemes.dracula").palette
		nx.hl({ "LspSagaWinbarFile", fg = palette.light_grey })
	elseif vim.g.colors_name == "tokyonight" then
		nx.hl({ "LspSagaWinbarFile", link = "NeoTreeGitRenamed" })
	end
end
-- <== }

return M
