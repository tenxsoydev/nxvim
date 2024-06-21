-- https://github.com/williamboman/mason-lspconfig.nvim

local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

-- { == Configuration ==> =====================================================

mason_lspconfig.setup()

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
	-- Attach keymaps and commands.
	require("nxvim.lsp").on_attach(client, bufnr)
	require("nxvim.lsp.plugins.lspsaga").on_attach(client, bufnr)
end

local opts = {
	capabilities = capabilities,
	on_attach = on_attach,
}

lspconfig.mojo.setup(opts)
lspconfig.sourcekit.setup(opts)

-- `:h mason-lspconfig-dynamic-server-setup`
mason_lspconfig.setup_handlers({
	function(server)
		local server_opts = opts
		--- Insert server settings from settings file if present.
		--- The name of the settings file must match the name of the language server.
		local server_settings_ok, server_settings = pcall(require, "nxvim.lsp.settings." .. server)
		if server_settings_ok then server_opts = vim.tbl_deep_extend("keep", server_settings, server_opts) end

		--- Or add settings inline.
		if server == "tsserver" then
			server_opts.on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
				opts.on_attach(client, bufnr)
			end
		end
		if server == "gopls" then goto setup end
		-- Use prettierd as formatter.
		if server == "jsonls" then server_opts.init_options = { provideFormatter = false } end
		if server == "zls" then vim.g.zig_fmt_autosave = 0 end

		::setup::
		lspconfig[server].setup(server_opts)
	end,
	["rust_analyzer"] = function() require("rust-tools").setup({ server = opts }) end,
})
-- <== }

-- { == Keymaps ==> ===========================================================

nx.map({
	{ "<leader>l+", ":LspStart ", desc = "Select Language Server to Start", wk_label = "Start LSP" },
	{ "<leader>l-", ":LspStop ", desc = "Select Language Server to Stop", wk_label = "Stop LSP" },
})
-- <==}
