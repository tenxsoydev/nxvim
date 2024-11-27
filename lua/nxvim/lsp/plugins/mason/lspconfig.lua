-- https://github.com/williamboman/mason-lspconfig.nvim

local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

-- == [ Configuration =========================================================

mason_lspconfig.setup()

local opts = {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	on_attach = function(client, bufnr)
		-- Attach keymaps and commands.
		require("nxvim.lsp").on_attach(client, bufnr)
		require("nxvim.lsp.plugins.lspsaga").on_attach(client, bufnr)
	end,
}

-- `:h mason-lspconfig-dynamic-server-setup`
mason_lspconfig.setup_handlers({
	function(server)
		local server_opts = opts
		--- Insert server settings from settings file if present.
		--- The name of the settings file must match the name of the language server.
		local server_settings_ok, server_settings = pcall(require, "nxvim.lsp.settings." .. server)
		if server_settings_ok then server_opts = vim.tbl_deep_extend("keep", server_settings, server_opts) end

		if server == "ts_ls" then
			server_opts.single_file_support = false
			server_opts.root_dir = lspconfig.util.root_pattern("package.json")
		elseif server == "denols" then
			server_opts.root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
		elseif server == "jsonls" then
			server_opts.init_options = { provideFormatter = false } -- Use prettierd as formatter.
		elseif server == "zls" then
			vim.g.zig_fmt_autosave = 0
		end

		lspconfig[server].setup(server_opts)
	end,
})

configs.c3lsp = {
	default_config = {
		cmd = { "c3lsp" },
		filetypes = { "c3", "c3i", "c3t" },
		single_file_support = true,
	},
	server = {},
}

configs.onyx = {
	default_config = {
		cmd = { "onyx", "lsp" },
		filetypes = { "onyx", "onyx-pkg.kdl" },
		single_file_support = true,
	},
	server = {},
}
vim.g.onyx_check_parse_errors = 0

lspconfig.mojo.setup(opts)
lspconfig.sourcekit.setup(opts)
lspconfig.onyx.setup(opts)
lspconfig.c3lsp.setup(opts)
-- ]

-- == [ Keymaps ===============================================================

nx.map({
	{ "<leader>l+", ":LspStart ", desc = "Select Language Server to Start", wk_label = "Start LSP" },
	{ "<leader>l-", ":LspStop ", desc = "Select Language Server to Stop", wk_label = "Stop LSP" },
})
-- ]
