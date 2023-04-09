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
-- A lot of terminal configs allow to specify different font families for font weights and styles.
-- Since bold-italic is not used very often, we can utilize it to display a second font.
-- We can use JetBrains as the default, and e.g. set Comments to bold-italic to use Fantasque for them.
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
		guifont = "JetBrainsMono Nerd Font Mono:h12.5",
		guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait600-blinkoff800-blinkon900-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175",
		linespace = 2,
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
