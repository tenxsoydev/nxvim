return {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "bit", "WindLine" },
				libraryFiles = true,
			},
			format = {
				enable = false,
			},
			-- use neodev to setup workspace
			--[[ workspace = {
				library = {
					vim.fn.stdpath("config") .. "/lua",
				},
			}, ]]
		},
	},
}
