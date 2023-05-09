-- https://github.com/AckslD/messages.nvim

-- { == Configuration ==> =====================================================

require("messages").setup({
	command_name = "Messages",
	prepare_buffer = function(opts)
		local buf = vim.api.nvim_create_buf(false, true)
		nx.map({
			{ { "q", "<C-c>", "<C-h>", "<C-j>", "<C-k>", "<C-l>" }, "<Cmd>close<CR>" },
		}, { buffer = buf, silent = true })
		return vim.api.nvim_open_win(buf, true, opts)
	end,
})
-- <== }
