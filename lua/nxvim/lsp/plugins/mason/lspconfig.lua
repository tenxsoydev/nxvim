-- https://github.com/williamboman/mason-lspconfig.nvim

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup()

local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local function on_attach()
	require("nxvim.lsp").on_attach()
	require("nxvim.lsp.plugins.lspsaga").on_attach()
end

mason_lspconfig.setup_handlers({
	function(server)
		local opts = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- Insert server settings from settings file if present
		local server_settings_ok, server_settings = pcall(require, "nxvim.lsp.settings." .. server)
		if server_settings_ok then opts = vim.tbl_deep_extend("keep", server_settings, opts) end

		-- Or add settings inline
		-- use prettierd as formatter
		if server == "jsonls" or "tsserver" then opts.init_options = { provideFormatter = false } end
		if server == "nimlsp" then vim.g.nim_nep1 = 0 end
		if server == "rust_analyzer" then goto continue end

		lspconfig[server].setup(opts)

		::continue::
	end,
})
