-- https://github.com/jose-elias-alvarez/null-ls.nvim

local null_ls = require("null-ls")
local fmt = null_ls.builtins.formatting
-- local diag = null_ls.builtins.diagnostics
-- local ca = null_ls.builtins.code_actions
-- local cmp = null_ls.builtins.completion.spell,

-- { == Configuration ==> =====================================================

null_ls.setup({
	debug = false,
	sources = {
		fmt.prettierd.with({
			-- filetypes = { "css", "scss", "vue", "json", "markdown", "typescript", "yaml" },
			filetypes = { "vue", "json", "markdown", "typescript", "yaml" },
			extra_args = { "--use-tabs", "--printWidth: 120", "--semi: true" },
		}),
		fmt.rustfmt,
		fmt.stylua,
		fmt.yapf,
		fmt.nimpretty,
	},
})
-- <== }
