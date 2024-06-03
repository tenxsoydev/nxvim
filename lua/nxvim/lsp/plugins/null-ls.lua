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
	name = "mojo-format",
	method = null_ls.methods.FORMATTING,
	filetypes = { "mojo" },
	generator = null_ls.formatter({
		command = "mojo",
		args = { "format", "-q", "-l", "100", "$FILENAME" },
		to_temp_file = true,
	}),
})

-- { == Configuration ==> =====================================================

null_ls.setup({
	debug = false,
	sources = {
		-- requires prettierd `pnpm i -g @fsouza/prettierd`
		fmt.prettierd.with({
			filetypes = {
				"markdown",
				"json",
				"jsonc",
				"typescript",
				"typescriptreact",
				"javascript",
				"javascriptreact",
				"vue",
				"yaml",
				"html",
				"css",
				"scss",
				"liquid",
				"njk",
			},
			extra_args = { "--use-tabs", "--printWidth: 100", "--semi", "--single-quote" },
		}),
		fmt.rustfmt,
		fmt.stylua,
		fmt.yapf,
	},
})
-- <== }
