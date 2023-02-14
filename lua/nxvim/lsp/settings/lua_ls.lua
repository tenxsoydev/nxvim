local settings = {
	Lua = {
		diagnostics = {
			globals = { "vim", "bit", "WindLine" },
		},
		format = {
			enable = false,
		},
		-- use neodev to setup workspace
		-- workspace = {
		-- 	library = {
		-- 		[vim.fn.expand "$VIMRUNTIME/lua"] = true,
		-- 		[vim.fn.stdpath "config" .. "/lua"] = true,
		-- 	},
		-- },
	},
}

if vim.g.colors_name == "dracula" then settings.Lua.semantic = {
	keyword = false,
	variable = false,
} end

return {
	settings = settings,
}
