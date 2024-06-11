-- https://github.com/williamboman/mason-lspconfig.nvim

local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

-- { == Configuration ==> =====================================================

mason_lspconfig.setup({
	-- ensure_installed = { "lua_ls" },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local function on_attach(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end
	-- Attach keymaps and commands.
	require("nxvim.lsp").on_attach(client, bufnr)
	require("nxvim.lsp.plugins.lspsaga").on_attach(client, bufnr)
end

lspconfig.mojo.setup({})

mason_lspconfig.setup_handlers({
	function(server)
		local opts = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- Handled by rust-tools.
		if server == "rust_analyzer" then goto continue end

		-- Insert server settings from settings file if present.
		-- The name of the settings file must match the name of the language server.
		local server_settings_ok, server_settings = pcall(require, "nxvim.lsp.settings." .. server)
		if server_settings_ok then opts = vim.tbl_deep_extend("keep", server_settings, opts) end

		-- Or add settings inline.
		--
		-- The json|ts provideFormatter setting below triggers for gopls when it shouldn't, therefore we skip it here.
		if server == "gopls" then goto setup end
		-- Use prettierd as formatter.
		if server == "jsonls" then opts.init_options = { provideFormatter = false } end
		if server == "zls" then vim.g.zig_fmt_autosave = 0 end

		::setup::
		lspconfig[server].setup(opts)

		::continue::
	end,
})
-- <== }

--- { == Keymaps ==> ===========================================================

nx.map({
	{ "<leader>l+", ":LspStart ", desc = "Select Language Server to Start", wk_label = "Start LSP" },
	{ "<leader>l-", ":LspStop ", desc = "Select Language Server to Stop", wk_label = "Stop LSP" },
})
-- <==}
