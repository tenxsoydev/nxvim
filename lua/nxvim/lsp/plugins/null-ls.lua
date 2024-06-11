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
		args = { "-w", "$FILENAME" },
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

null_ls.register({
	name = "vzit",
	method = null_ls.methods.FORMATTING,
	filetypes = { "zig" },
	generator = null_ls.formatter({
		command = "vzit",
		args = { "-w", "$FILENAME" },
		to_temp_file = true,
	}),
})

-- { == Configuration ==> =====================================================

null_ls.setup({
	debug = false,
	sources = {
		-- requires prettierd `bun i -g @fsouza/prettierd`
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
		fmt.stylua,
		fmt.yapf,
	},
})

---@diagnostic disable-next-line: missing-fields
require("mason-null-ls").setup({ handlers = {} })
-- <== }
