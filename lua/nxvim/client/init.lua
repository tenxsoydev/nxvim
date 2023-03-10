local M = {}

for _, client in ipairs({ "gnvim", "goneovim", "neovide", "nvui", "fvim_loaded" }) do
	if vim.g[client] then vim.g.nx_loaded_gui = client end
end

local function init_gui()
	-- General GUI options
	local opts = {
		fillchars__append = [[vert:│]],
		guifont = "JetBrainsMono Nerd Font Mono:h12.5",
		guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait600-blinkoff800-blinkon900-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175",
		linespace = 2,
		winblend = 10,
		pumblend = 10,
	}

	-- GUI Plugins
	require("nxvim.plugins.size-matters")

	return opts
end

function M.load_opts()
	if not vim.g.nx_loaded_gui then return end

	local gui_opts = init_gui()
	local client_opts = require("nxvim.client." .. vim.g.nx_loaded_gui)
	vim.schedule(function() nx.set(vim.tbl_deep_extend("keep", client_opts, gui_opts), vim.opt) end)
end

return M
