-- https://github.com/tenxsoydev/size-matters.nvim

local size_matters = require("size-matters")

-- { == Configuration ==> =====================================================

local step_size = 1
if vim.g.neovide then step_size = 0.5 end

size_matters.setup({
	step_size = step_size,
})
-- <== }
