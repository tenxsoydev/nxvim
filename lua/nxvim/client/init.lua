local M = {}

if vim.fn.has("nvim-0.9.0") ~= 1 then
	vim.defer_fn(
		function() vim.notify("nxvim requires neovim version >= 0.9 for unimpaired usage", vim.log.levels.WARN) end,
		300
	)
end

---@class NxOpts
---@field float_win_border "single"|"rounded"|"double"|"none" @border style for float windows and cmp popups
---@field transparency boolean
-- Most modern terminal configs allow specifying different fonts for weight and style variants.
-- For example, we can utilize bold-italic to display a second font (TODO: link to e.g./docs https://...).
---@field second_font boolean
nx.opts = {
	float_win_border = "rounded",
	transparency = true,
	second_font = false,
}

for _, client in ipairs({ "gnvim", "goneovim", "neovide", "nvui", "fvim_loaded" }) do
	if vim.g[client] then vim.g.loaded_gui = client end
end

local function init_gui()
	-- General GUI options
	local opts = {
		fillchars__append = [[vert:│]],
		guifont = vim.g.osx and "Hasklug Nerd Font Mono:h14" or "Hasklug Nerd Font Mono:h11",
		guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait600-blinkoff800-blinkon900-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175",
		linespace = vim.g.osx and 3 or 2,
		winblend = 10,
		pumblend = 10,
	}
	nx.opts.second_font = false

	-- GUI Plugins
	require("nxvim.plugins.size-matters")

	return opts
end

function M.load_opts()
	if not vim.g.loaded_gui then return end

	local gui_opts = init_gui()
	local client_opts = require("nxvim.client." .. vim.g.loaded_gui)

	vim.schedule(function() nx.set(vim.tbl_deep_extend("keep", client_opts, gui_opts), vim.opt) end)
end

return M
