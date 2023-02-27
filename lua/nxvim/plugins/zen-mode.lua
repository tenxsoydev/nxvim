local zen_mode = require("zen-mode")

-- { == Configuration ==> =====================================================

zen_mode.setup({
	window = {
		-- backdrop = 0.96, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
		-- height and width can be:
		-- * an absolute number of cells when > 1
		-- * a percentage of the width / height of the editor when <= 1
		-- * a function that returns the width or the height
		width = 126, -- width of the Zen window
		height = function() return vim.fn.winheight(0) + 1 end, -- height of the Zen window
		-- by default, no options are changed for the Zen window
		-- uncomment any of the options below, or add other vim.wo options you want to apply
	},
	plugins = {
		-- disable some global vim options (vim.o...)
		-- comment the lines to not apply the options
		options = {
			enabled = true,
			ruler = false, -- disables the ruler text in the cmd line area
			showcmd = false, -- disables the command in the last line of the screen
		},
	},
	on_open = function()
		vim.g.zen_mode = true
		vim.o.laststatus = 3
		-- vim.diagnostic.disable()
		--[[ if not vim.g.neovide then return end
		vim.g.neovide_floating_blur = 1
		vim.g.neovide_floating_opacity = 0.98 ]]
	end,
	on_close = function()
		vim.g.zen_mode = nil
		vim.o.laststatus = 2
		-- vim.diagnostic.enable()
		--[[ if not vim.g.neovide then return end
		vim.g.neovide_floating_opacity = 0.8
		vim.g.neovide_floating_blur = 0.9 ]]
	end,
})
-- <== }

-- Keymaps ====================================================================

nx.map({
	{ "<leader>z", "<Cmd>ZenMode<CR>", desc = "Zen mode toggle" },
	{ "<C-z>", "<Cmd>ZenMode<CR>", desc = "Zen mode toggle" },
})
-- <== }
