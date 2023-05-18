-- https://github.com/mg979/vim-visual-multi

vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/visual-multi")

-- { == Keymaps ==> ===========================================================

-- https://github.com/mg979/vim-visual-multi/wiki/Mappings
vim.g.VM_mouse_mappings = 1
vim.g.VM_leader = [[\]]
vim.g.VM_maps = {
	["Find Under"] = vim.g.eu_kbd and "ñ" or "<A-n>",
	["Find Subword Under"] = vim.g.eu_kbd and "ñ" and "<A-n>",
	["Undo"] = "u",
	["Redo"] = "<C-r>",
	["Add Cursor Up"] = "<A-C-k>",
	["Add Cursor Down"] = "<A-C-j>",
	-- Remap to use Shift Left / Right for horizontal scrolling
	["Select l"] = "<A-C-Right>",
	["Select h"] = "<A-C-Left>",
}

-- <== }
