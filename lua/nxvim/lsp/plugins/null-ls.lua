-- https://github.com/jose-elias-alvarez/null-ls.nvim

local null_ls = require("null-ls")
local fmt = null_ls.builtins.formatting
-- local diag = null_ls.builtins.diagnostics
-- local ca = null_ls.builtins.code_actions
-- local cmp = null_ls.builtins.completion.spell,

null_ls.register({
	name = "nimpretty_t",
	method = null_ls.methods.FORMATTING,
	filetypes = { "nim" },
	generator = null_ls.formatter({
		command = "nimpretty_t",
		args = { "$FILENAME", "--maxLineLen=100" },
		to_temp_file = true,
	}),
})

null_ls.register({
	name = "vfmt",
	method = null_ls.methods.FORMATTING,
	filetypes = { "v", "vlang" },
	generator = null_ls.formatter({
		command = "v",
		args = { "fmt", "-w", "$FILENAME" },
		to_temp_file = true,
	}),
})

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
	},
})
-- <== }
