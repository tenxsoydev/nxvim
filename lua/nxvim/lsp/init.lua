local M = {}

-- == [ Configuration =========================================================

local border = nx.opts.float_win_border

vim.fn.sign_define("DiagnosticSignError", { text = "󰅙" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "" })

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
-- ]

-- == [ Commands ==============================================================

local function toggle_buffer_diags()
	local next_state = not vim.diagnostic.is_enabled()
	vim.diagnostic.enable(next_state, { bufnr = vim.api.nvim_get_current_buf() })
	vim.notify((next_state and "Enabled" or "Disabled") .. " Diagnostics for Buffer")
end

local function toggle_diags()
	local next_state = not vim.diagnostic.is_enabled()
	vim.diagnostic.enable(next_state)
	vim.notify((next_state and "Enabled" or "Disabled") .. " Diagnostics")
end

local function toggle_inlay_hints()
	local next_state = not vim.lsp.inlay_hint.is_enabled()
	vim.lsp.inlay_hint.enable(next_state)
	vim.notify((next_state and "Enabled" or "Disabled") .. " Inlay Hints")
end

---@param notify? boolean
local function toggle_format_on_save(notify)
	if vim.fn.exists("#FormatOnSave") ~= 0 then
		vim.api.nvim_del_augroup_by_name("FormatOnSave")
		if notify then vim.notify("Disabled Format on Save") end
		return
	end

	nx.au({
		"BufWritePre",
		create_group = "FormatOnSave",
		callback = function()
			vim.lsp.buf.format({
				async = false,
				filter = function(client)
					for _, name in ipairs({ "zls", "ts_ls", "volar" }) do
						if name == client.name then return false end
					end
					return true
				end,
			})
		end,
	})
	if notify then vim.notify("Enabled Format on Save") end
end

toggle_format_on_save()

nx.cmd({
	{ "LspFormat", function() vim.lsp.buf.format({ async = true }) end, bang = true },
	{ "LspToggleAutoFormat", function() toggle_format_on_save(true) end, bang = true },
	{ "ToggleBufferDiagnostics", function() toggle_buffer_diags() end, bang = true },
})
-- ]

--- == [ Keymaps ===============================================================

nx.map({
	{ "<leader>q", vim.diagnostic.setloclist, desc = "Buffer Diagnostics", wk_label = "Quickfix" },
	{ "<leader>db", vim.diagnostic.setloclist, desc = "Buffer Diagnostics" },
	{ "gl", function() vim.diagnostic.open_float({ border = border }) end, desc = "Show Diagnostics" },
	{
		"gL",
		function() vim.diagnostic.open_float({ scope = "cursor", border = border }) end,
		desc = "Show Diagnostics",
	},
	-- Keymaps for user commands
	{ "<leader>dtt", toggle_buffer_diags, desc = "Toggle Buffer Diagnostics" },
	{ "<leader>tdt", toggle_buffer_diags, desc = "Toggle ", wk_label = "Buffer Diagnostics" },
	{ "<leader>tdT", toggle_diags, desc = "Toggle Diagnostics", wk_label = "Diagnostics" },
	{ "<leader>dtT", toggle_diags, desc = "Toggle Diagnostics", wk_label = "Diagnostics" },
	{ "<leader>dj", function() vim.diagnostic.jump({ count = 1 }) end, desc = "Next diagnostic" },
	{ "<leader>dk", function() vim.diagnostic.jump({ count = -1 }) end, desc = "Previous diagnostic" },
})

---@param bufnr number
function M.on_attach(_, bufnr)
	nx.map({
		{ "K", vim.lsp.buf.hover, desc = "LSP Hover" },
		{ "gh", vim.lsp.buf.signature_help, desc = "Signatrue Help" },
		-- Use mostly saga
		-- { "gr", vim.lsp.buf.references, desc = "List References" },
		-- { "<C-.>", vim.lsp.buf.code_action, desc = "Code action" },
		-- { "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
		-- { "gD", vim.lsp.buf.declaration, desc = "Goto declaration" },
		-- { "<leader>lr", vim.lsp.buf.references, desc = "List References" },
		-- { "<F11>", vim.lsp.buf.references, desc = "List References" },
		-- { "<F12>", vim.lsp.buf.definition, desc = "Go to Definition" },
		-- { "<leader>ld", vim.lsp.buf.definition, desc = "Definitions" },
		-- { "<leader>li", vim.lsp.buf.implementation, desc = "Goto implementation" },
		{
			"<F2>",
			function()
				nx.au({
					"FileType",
					pattern = "DressingInput",
					once = true,
					callback = function()
						-- Start rename input dialog with selected content
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>^vE", true, false, true), "n", false)
					end,
				})
				vim.lsp.buf.rename()
			end,
			{ "i", "n" },
			desc = "Rename",
		},

		-- Keymaps for user commands
		{ { "<leader>ti", "<leader>li" }, toggle_inlay_hints, desc = "Toggle Inlay Hints", wk_label = "Inlay Hints" },
		{ { "<leader>fF", "<leader>lf" }, "<Cmd>LspFormat<CR>", desc = "Format Buffer" },
		-- stylua: ignore
		{ { "<leader>tF", "<leader>lF" }, "<Cmd>LspToggleAutoFormat<CR>", desc = "Toggle Format on Save", wk_label = "Format on Save" },
	}, { buffer = bufnr })
end
-- ]

return M
