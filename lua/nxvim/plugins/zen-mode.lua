-- https://github.com/folke/zen-mode.nvim

local zen_mode = require("zen-mode")

-- { == Configuration ==> =====================================================

local config = {
	window = {
		--[[ width = tonumber(string.match(vim.o.colorcolumn, "%d+")) + vim.o.foldcolumn + vim.o.numberwidth + tonumber(
			string.match(vim.o.signcolumn, "%d+")
		), ]]
		width = 126,
		height = function() return vim.fn.winheight(0) + (vim.fn.has("nvim-0.9.0") == 1 and 3 or 1) end,
	},
	-- See events section below
	on_open = nil,
	on_close = nil,
}
-- <== }

-- { == Events ==> ============================================================

config.on_open = function()
	vim.g.zen_mode = true -- Used e.g. for wilder popmenu
	vim.o.laststatus = 3 -- Keep statusline(not working with latest nighlty 20230328).
	vim.wo.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:›,vert:▏]]
	vim.cmd("ScrollbarHide")

	-- Disable default window-switch keymaps as they would close zen-mode.
	nx.map({ { "<C-h>", "<C-j>", "<C-k>", "<C-l>" }, "<nop>" })

	-- Old neovide settings. Need to be checked.
	--[[ if not vim.g.neovide then return end
		vim.g.neovide_floating_blur = 1
		vim.g.neovide_floating_opacity = 0.98 ]]
end
config.on_close = function()
	vim.g.zen_mode = nil
	vim.o.laststatus = 2
	vim.cmd("ScrollbarShow")
	-- Re-enable default window-switch keymaps.
	require("nxvim.plugins.smart-splits").set_maps()

	--[[ if not vim.g.neovide then return end
		vim.g.neovide_floating_opacity = 0.8
		vim.g.neovide_floating_blur = 0.9 ]]
end

-- <== }

-- { == Load Setup ==> =======================================================-

zen_mode.setup(config)
-- <== }

-- Keymaps ====================================================================

nx.map({
	{ "<leader>z", "<Cmd>ZenMode<CR>", desc = "Toggle Zen Mode", wk_label = "Zen Mode" },
	{ "<C-z>", "<Cmd>ZenMode<CR>", desc = "Toggle Zen Mode" },
})
-- <== }
