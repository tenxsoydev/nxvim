local M = {}

-- { == Configuration ==> =====================================================

local border = "rounded"
local icons = require("nxvim.icons").nerd_solid
local signs = {
	{ name = "DiagnosticSignError", text = icons.CircleStop },
	{ name = "DiagnosticSignWarn", text = icons.Warning },
	{ name = "DiagnosticSignHint", text = icons.Lightbulb },
	{ name = "DiagnosticSignInfo", text = icons.Info },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })

-- <== }

-- { == Commands ==============================================================

---@type { [number]: boolean }
local diag_disabled_buffers = {}
---@param bufnr number
local function toggle_buffer_diags(bufnr)
	if diag_disabled_buffers[bufnr] == nil or not diag_disabled_buffers[bufnr] then
		vim.diagnostic.disable(bufnr)
		diag_disabled_buffers[bufnr] = true
		vim.notify("Disabled Diagnostics for Buffer")
	else
		vim.diagnostic.enable(bufnr)
		diag_disabled_buffers[bufnr] = false
		vim.notify("Enabled Diagnostics for Buffer")
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
			if next(vim.lsp.get_active_clients({ bufnr = 0 })) == nil then return end
			vim.lsp.buf.format({ async = false })
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
-- <== }

--- { == Keymaps ==> ===========================================================

function M.on_attach(_, bufnr)
	nx.map({
		{ "<leader>db", function() vim.diagnostic.setloclist() end, desc = "Buffer Diagnostics" },
		{ "<leader>q", function() vim.diagnostic.setloclist() end, desc = "Buffer Diagnostics", wk_label = "Quickfix" },
		{ "K", function() vim.lsp.buf.hover() end, desc = "LSP Hover" },
		{ "gd", function() vim.lsp.buf.definition() end, desc = "Go to Definition" },
		{ "gl", function() vim.diagnostic.open_float({ border = border }) end, desc = "Show Diagnostics" },
		{
			"gL",
			function() vim.diagnostic.open_float({ scope = "cursor", border = border }) end,
			desc = "Show Diagnostics",
		},
		-- { "gh", function() vim.lsp.buf.signature_help() end, desc = "Signatrue Help" },
		-- {"<C-.>", function() vim.lsp.buf.code_action() end,  desc = "Code action" },
		-- {"gD", function() vim.lsp.buf.declaration() end,  desc = "Goto declaration" },
		{ "<leader>lr", function() vim.lsp.buf.references() end, desc = "List References" },
		-- { "<F11>", "<Cmd>lua vim.lsp.buf.references()<CR>", desc = "List References" },
		-- { "<F12>", "<Cmd>lua vim.lsp.buf.definition()<CR>", desc = "Go to Definition" },

		-- {"<leader>dj", function() vim.diagnostic.goto_next({ buffer = 0 }) end,  desc = "Next diagnostic" },
		-- {"<leader>dk", function() vim.diagnostic.goto_prev({ buffer = 0 }) end,  desc = "Previous diagnostic" },
		-- {"<leader>lr", "<Cmd>lua vim.lsp.buf.references()<CR>",  desc = "References" },
		-- {"<leader>ld", "<Cmd>lua vim.lsp.buf.definition()<CR>",  desc = "Definitions" },
		-- {"<leader>li", "<Cmd>lua vim.lsp.buf.implementation()<CR>",  desc = "Goto implementation" },
		{
			"<F2>",
			function()
				nx.au({
					"FileType",
					pattern = "DressingInput",
					once = true,
					callback = function()
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
		{ "<leader>fF", "<Cmd>LspFormat<CR>", desc = "Format Buffer" },
		{ "<leader>tF", "<Cmd>LspToggleAutoFormat<CR>", desc = "Toggle Format on Save", wk_label = "Format on Save" },
		{ "<leader>dtt", "<Cmd>ToggleBufferDiagnostics<CR>", desc = "Toggle Buffer Diagnostics" },
		{
			"<leader>tdt",
			"<Cmd>ToggleBufferDiagnostics<CR>",
			desc = "Toggle Buffer Diagnostics",
			wk_label = { sub_desc = "Toggle" },
		},
	}, { buffer = bufnr })
end
-- <== }

return M
