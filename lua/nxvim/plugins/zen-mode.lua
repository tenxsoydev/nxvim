-- https://github.com/folke/zen-mode.nvim

local zen_mode = require("zen-mode")

-- { == Configuration ==> =====================================================

zen_mode.setup({
	window = {
		--[[ width = tonumber(string.match(vim.o.colorcolumn, "%d+")) + vim.o.foldcolumn + vim.o.numberwidth + tonumber(
			string.match(vim.o.signcolumn, "%d+")
		), ]]
		width = 126,
		height = function() return vim.fn.winheight(0) + (vim.fn.has("nvim-0.9.0") == 1 and 3 or 1) end,
	},
	on_open = function()
		vim.g.zen_mode = true
		vim.o.laststatus = 3
		vim.wo.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:›,vert:▏]]
		nx.map({
			{ "<C-h>", "<C-h>" },
			{ "<C-j>", "<C-j>" },
			{ "<C-k>", "<C-k>" },
			{ "<C-l>", "<C-l>" },
		})
		--[[ if not vim.g.neovide then return end
		vim.g.neovide_floating_blur = 1
		vim.g.neovide_floating_opacity = 0.98 ]]
	end,
	on_close = function()
		vim.g.zen_mode = nil
		vim.o.laststatus = 2
		require("nxvim.plugins.smart-splits").set_maps()
		--[[ if not vim.g.neovide then return end
		vim.g.neovide_floating_opacity = 0.8
		vim.g.neovide_floating_blur = 0.9 ]]
	end,
})
-- <== }

-- Keymaps ====================================================================

nx.map({
	{ "<leader>z", "<Cmd>ZenMode<CR>", desc = "Toggle Zen Mode", wk_label = "Zen Mode" },
	{ "<C-z>", "<Cmd>ZenMode<CR>", desc = "Toggle Zen Mode" },
})
-- <== }
