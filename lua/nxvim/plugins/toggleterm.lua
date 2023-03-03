-- https://github.com/akinsho/toggleterm.nvim

-- { == Configuration ==> =====================================================

require("toggleterm").setup({
	size = 20,
	open_mapping = [[<C-\>]],
	on_open = function(term)
		set_terminal_keymaps()
		vim.cmd("setlocal nonumber norelativenumber signcolumn=no")
		if term.direction == "tab" then
			vim.o.showtabline = 0
			vim.o.cmdheight = 0
		end
	end,
	on_close = function(term)
		if term.direction == "tab" then vim.o.showtabline = 2 end
	end,
	hide_numbers = false,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = false,
	shell = vim.o.shell,
	auto_scroll = false,
	float_opts = {
		border = "curved",
		winblend = vim.o.winblend,
	},
	highlights = {
		Normal = {
			link = "Normal",
		},
		FloatBorder = {
			link = "FloatBorder",
		},
	},
})
-- <== }

-- { == Custom Terminals ==> ==================================================

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
	cmd = "lazygit",
	dir = "git_dir",
	on_open = function(term) set_lazygit_keymaps(term) end,
	close_on_exit = true,
})
function _G.lazygit_toggle() lazygit:toggle() end

local gitui = Terminal:new({
	cmd = "gitui",
	dir = "git_dir",
	on_open = function(term) set_lazygit_keymaps(term) end,
	close_on_exit = true,
})
function _G.gitui_toggle() gitui:toggle() end

local ncdu = Terminal:new({ cmd = "ncdu", hidden = true, close_on_exit = true })
function _G.ncdu_toggle() ncdu:toggle() end

local btop = Terminal:new({ cmd = "btop", hidden = true, close_on_exit = true })
function _G.btop_toggle() btop:toggle() end
-- <== }

-- { == Keymaps ==> ===========================================================

nx.map({
	-- Ctrl-Escape won't work in some TUIs, works in kitty and GUIs
	{ "<C-Esc>", "<Cmd>ToggleTerm<CR>", { "t", "n" }, desc = "Toggle Terminal" },
	{ "<leader>``", "<Cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
	{ "<leader>t`", "<Cmd>ToggleTerm<CR>", desc = "Toggle Terminal", wk_label = "Terminal" },
	{ "<leader>`h", "<Cmd>ToggleTerm size=10 direction=horizontal<CR>", desc = "Horizontal" },
	{ "<leader>`f", "<Cmd>ToggleTerm direction=float<CR>", desc = "Float" },
	{ "<leader>`v", "<Cmd>ToggleTerm size=80 direction=vertical<CR>", desc = "Vertical" },
	{ "<leader>`t", "<Cmd>ToggleTerm direction=tab<CR>", desc = "Tab" },
	-- Terminal quick access gui and kitty mappings
	-- Equivalents in kitty to e.g., `<C-F1>` is `<F25>`
	{ { "<C-F1>", "<F25>", "<leader>`1" }, "<Cmd>1ToggleTerm<CR>", { "", "t" }, desc = "Toggle Terminal #1" },
	{ { "<C-F2>", "<F26>", "<leader>`2" }, "<Cmd>2ToggleTerm<CR>", { "", "t" }, desc = "Toggle Terminal #2" },
	{ { "<C-F3>", "<F27>", "<leader>`3" }, "<Cmd>3ToggleTerm<CR>", { "", "t" }, desc = "Toggle Terminal #3" },
	{ { "<C-F4>", "<F28>", "<leader>`4" }, "<Cmd>4ToggleTerm<CR>", { "", "t" }, desc = "Toggle Terminal #4" },
	-- External injections
	{ "<leader>gt", "<Cmd>lua lazygit_toggle()<CR>", "", desc = "Terminal UI" },
	{ "<leader>`r", "<Cmd>lua btop_toggle()<CR>", desc = "Btop Resource Monitor" },
	{ "<leader>`u", "<Cmd>lua ncdu_toggle()<CR>", desc = "NCurses Disk Usage" },
})

function _G.set_terminal_keymaps()
	nx.map({
		{ "a", "A", "n" },
		{ "i", "I", "n" },
		{ "jk", "<C-\\><C-n>" },
	}, { buffer = 0, mode = "t" })
end

function _G.set_lazygit_keymaps(term) nx.map({ { "<C-j><C-k>", "<C-\\><C-n>", "t", buffer = term.bufnr } }) end
-- <== }
