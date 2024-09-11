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

---@type { [number]: boolean }
local diag_disabled_buffers = {}
---@param bufnr number
local function toggle_buffer_diags(bufnr)
	if diag_disabled_buffers[bufnr] then
		vim.diagnostic.enable(true, { bufnr = bufnr })
		diag_disabled_buffers[bufnr] = false
		vim.notify("Enabled Diagnostics for Buffer")
	else
		vim.diagnostic.enable(false, { bufnr = bufnr })
		diag_disabled_buffers[bufnr] = true
		vim.notify("Disabled Diagnostics for Buffer")
	end
end

---@param silent? "silent"
local function toggle_format_on_save(silent)
	if vim.fn.exists("#FormatOnSave") ~= 0 then
		vim.api.nvim_del_augroup_by_name("FormatOnSave")
		if silent ~= "silent" then vim.notify("Disabled Format on Save") end
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
	if silent ~= "silent" then vim.notify("Enabled Format on Save") end
end

-- enable format on save by default
toggle_format_on_save("silent")

nx.cmd({
	{ "LspFormat", function() vim.lsp.buf.format({ async = true }) end, bang = true },
	{ "LspToggleAutoFormat", function(opt) toggle_format_on_save(opt.args) end, bang = true, nargs = "?" },
	{ "ToggleBufferDiagnostics", function() toggle_buffer_diags(vim.fn.bufnr()) end, bang = true },
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
	{ "<leader>dtt", "<Cmd>ToggleBufferDiagnostics<CR>", desc = "Toggle Buffer Diagnostics" },
	{ "<leader>tdt", "<Cmd>ToggleBufferDiagnostics<CR>", desc = "Toggle ", wk_label = "Buffer Diagnostics" },
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

		-- Telescope
		{ "<leader>ls", "<Cmd>Telescope lsp_document_symbols<CR>", desc = "Document Symbols" },
		{ "<leader>lS", "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Workspace Symbols" },

		-- Keymaps for user commands
		{ { "<leader>fF", "<leader>lf" }, "<Cmd>LspFormat<CR>", desc = "Format Buffer" },
		-- stylua: ignore
		{ { "<leader>tF", "<leader>lF" }, "<Cmd>LspToggleAutoFormat<CR>", desc = "Toggle Format on Save", wk_label = "Format on Save" },
	}, { buffer = bufnr })
end
-- ]

return M
