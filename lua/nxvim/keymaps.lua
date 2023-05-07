--[[ Mode reference (see `:h map-table`)
	┌──────┬──────┬─────┬─────┬─────┬─────┬─────┬──────┬──────┐
	│ Mode │ Norm │ Ins │ Cmd │ Vis │ Sel │ Opr │ Term │ Lang │
	├──────┼──────┼─────┼─────┼─────┼─────┼─────┼──────┼──────┤
	│ ""   │     │  -  │  -  │    │    │    │  -   │  -   │
	│ "n"  │     │  -  │  -  │  -  │  -  │  -  │  -   │  -   │
	│ "!"  │  -   │    │    │  -  │  -  │  -  │  -   │  -   │
	│ "i"  │  -   │    │  -  │  -  │  -  │  -  │  -   │  -   │
	│ "c"  │  -   │  -  │    │  -  │  -  │  -  │  -   │  -   │
	│ "v"  │  -   │  -  │  -  │    │    │  -  │  -   │  -   │
	│ "x"  │  -   │  -  │  -  │    │  -  │  -  │  -   │  -   │
	│ "s"  │  -   │  -  │  -  │  -  │    │  -  │  -   │  -   │
	│ "o"  │  -   │  -  │  -  │  -  │  -  │    │  -   │  -   │
	│ "t"  │  -   │  -  │  -  │  -  │  -  │  -  │     │  -   │
	│ "l"  │  -   │    │    │  -  │  -  │  -  │  -   │     │
	└──────┴──────┴─────┴─────┴─────┴─────┴─────┴──────┴──────┘
]]

-- { == Global Keymaps ==> ====================================================

-- Leader key
vim.g.mapleader = " "

nx.map({
	-- QUICK COMMANDS
	-- `;` for `f` etc. would still trigger after `timeoutlen`. However, we use `hop.nvim` anyway
	{ ";w", "<Cmd>w<CR>", desc = "Write Buffer" },
	{ ";c", function() MiniBufremove.delete(0, false) end, "", desc = "Close Buffer" },
	{ ";C", "<Cmd>tabclose<CR>", "", desc = "Close Tab" },
	{ ";q", "<Cmd>confirm quit<CR>", desc = "Close Window" },
	{ ";Q", "<Cmd>confirm qa<CR>", desc = "Close Application" },
	{ "ZQ", "<Cmd>confirm qa<CR>", desc = "Close Application" },
	-- { "<C-s>", "<Cmd>w<CR>", "", desc = "Save File" },
	-- { "<C-s>", "<Esc><Cmd>w<CR>", "i", desc = "Save File"  },

	-- LINE NAVIGATION
	{ { "j", "<Up>" }, "&wrap ? 'gj' : 'j'", "", expr = true, silent = true },
	{ { "k", "<Down>" }, "&wrap ? 'gk' : 'k'", "", expr = true, silent = true },
	{ "$", "&wrap ? 'g$' : '$'", "", expr = true, silent = true },
	{ "^", "&wrap ? 'g^' : '^'", "", expr = true, silent = true },
	-- Duplicate Lines
	{ vim.g.osx_eu and "Ú" or "<A-S-j>", '"yyy"yp', desc = "Duplicate Line Down" },
	{ vim.g.osx_eu and "Ĳ" or "<A-S-k>", '"yyy"yP', desc = "Duplicate Line Up" },
	{ vim.g.osx_eu and "Ú" or "<A-S-j>", "\"dy']\"dp`]'[V']", "v", desc = "Duplicate Lines Down" },
	{ vim.g.osx_eu and "Ĳ" or "<A-S-k>", "\"dy\"dP'[V']", "v", desc = "Duplicate Lines Up" },
	-- Add Blank Line, Stay in Normal Mode
	{ vim.g.osx_eu and "ö" or "<A-o>", 'o<Esc>^"_D', desc = "Add Blank Line Below" },
	{ vim.g.osx_eu and "Ö" or "<A-O>", 'O<Esc>^"_D', desc = "Add Blank Line Above" },
	-- Indentation
	-- NOTE: mapping <Tab> in normal mode == mapping <C-i>
	{ "<S-Tab>", "<C-d>", "i", desc = "Outdent" },
	-- Use correct indetation level when entering insert mode on empty lines
	{ "i", "len(getline('.')) == 0 ? '\"_cc' : 'i'", expr = true, silent = true },
	{ "a", "len(getline('.')) == 0 ? '\"_cc' : 'a'", expr = true, silent = true },
	{ "A", "len(getline('.')) == 0 ? '\"_cc' : 'A'", expr = true, silent = true },
	-- Preserve Selection when Indenting
	{ "<Tab>", ">gv", "x", desc = "Indent" },
	{ "<S-Tab>", "<gv", "v", desc = "Outdent" },
	{ ">", ">gv", "v", desc = "Indent" },
	{ "<", "<gv", "v", desc = "Outdent" },
	-- Change Indent Size (requires tab indentation)
	{ "<M-S-.>", "<Cmd>set ts+=1 sw=0 ts?<CR>", desc = "Increase Indentation Width" },
	{ "<M-S-,>", "<Cmd>set ts-=1 sw=0 ts?<CR>", desc = "Decrease Indentation Width" },

	-- WINDOW NAVIGATION
	-- Quick Switch Windows
	{ "<C-w>1", "1<C-w><C-w>", desc = "Go to Window #1", wk_label = "ignore" },
	{ "<C-w>2", "2<C-w><C-w>", desc = "Go to Window #2", wk_label = "ignore" },
	{ "<C-w>3", "3<C-w><C-w>", desc = "Go to Window #3", wk_label = "ignore" },
	{ "<C-w>4", "4<C-w><C-w>", desc = "Go to Window #4", wk_label = "ignore" },
	{ "<C-w>5", "5<C-w><C-w>", desc = "Go to Window #5", wk_label = "ignore" },
	-- Set Window Width to Colorcolumn (other predefined window width layouts are handled by windows.nvim)
	{
		"<C-w>b",
		function()
			---@param col "colorcolumn"|"numberwidth"|"signcolumn"
			local function get_width(col)
				local width = vim.api.nvim_get_option_value(col, { scope = "global" })
				if col == "signcolumn" then width = width:match("[0-9]") end
				return width
			end
			local widths = {
				s = get_width("signcolumn"),
				n = get_width("numberwidth"),
				c = get_width("colorcolumn"),
			}
			vim.api.nvim_win_set_width(0, widths.s + widths.n + widths.c)
		end,
		desc = "Set Window Width to Colorcolumn",
		silent = true,
	},

	-- TAB NAVIGATION
	{ "<C-Tab>", "<Cmd>tabnext<CR>", "", desc = "Go to Next Tab", silent = true },
	{ "<C-S-Tab>", "<Cmd>tabprevious<CR>", "", desc = "Go to Previous Tab", silent = true },
	{ "<C-w>tt", "<Cmd>tabnew | lua MiniBufremove.delete(0, false)<CR>", desc = "New Tab", wk_label = "New" },
	{ "<C-w>tc", "<Cmd>tabc<CR>", desc = "Close Current Tab", wk_label = "Close Current" },
	{ "<C-w>tC", "<Cmd>tabo<CR>", desc = "Close All Other Tabs", wk_label = "Close All Other" },
	{ "<C-w>c", "<Cmd>Bd<CR>", desc = "Close Buffer" },
	{ "<C-w>q", "<Cmd>confirm quit<CR>", desc = "Quit Window" },

	-- COMMANDLINE
	{ "<C-n>", "<Down>", "c", desc = "Next Related Command History Item" },
	{ "<C-p>", "<Up>", "c", desc = "Previous Related Command History Item" },
	{ "<Down>", "<C-n>", "c", desc = "Next Command History Item" },
	{ "<Up>", "<C-p>", "c", desc = "Previous Command History Item" },

	-- SEARCH
	{ "<C-c><C-c>", "<Cmd>noh<CR>", desc = "Clear Search Highlighting" },
	{ "<Esc><Esc>", "<Cmd>noh<CR>", desc = "Clear Search Highlighting" },
	{ "/", 'y/\\V<C-r>"<Esc>', "v", desc = "Search Selection" },

	-- LEADER KEYMAPS
	-- Config Quick Access
	{ "<leader>,u", "<Cmd>e ~/.config/nvim/lua/nxvim/utils.lua<CR>", desc = "Open Utils" },
	{ "<leader>,a", "<Cmd>e ~/.config/nvim/lua/nxvim/autocmds.lua<CR>", desc = "Open Autocmds" },
	-- { "<leader>,i", "<Cmd>e ~/.config/nvim/init.lua<CR>", desc = "Open Init" },
	{ "<leader>,,", "<Cmd>e ~/.config/nvim/lua/nxvim/init.lua<CR>", desc = "Open Init" },
	{ "<leader>,o", "<Cmd>e ~/.config/nvim/lua/nxvim/options.lua<CR>", desc = "Open Options" },
	{ "<leader>,w", "<Cmd>e ~/.config/nvim/lua/nxvim/plugins/which-key.lua<CR>", desc = "Which-Key" },
	-- File
	{ "<leader>fn", "<Cmd>ene!<CR>", desc = "New File" },
	{ "<leader>fw", "<Cmd>noa w<CR>", desc = "Write Without Formatting" },
	{ "<leader>fW", "<Cmd>w !sudo -A tee > /dev/null %<CR>", desc = "Write!" },
	{
		"<leader>fo",
		"<Cmd>silent execute '!xdg-open ' . '%:p:h'<CR>",
		desc = "Open File with System App",
		wk_label = "System Open",
	},
	{
		"<leader>fy",
		"<Cmd>let @+ = expand('%')<CR>",
		desc = "Yank Relative Path of Active File",
		wk_label = "Yank Relative Path",
	},
	{
		"<leader>fY",
		"<Cmd>let @+ = expand('%:p')<CR>",
		desc = "Yank Full Path of Active File",
		wk_label = "Yank Full Path",
	},
	-- Toggles
	{
		"<leader>ts",
		function()
			vim.o.spell = not vim.o.spell
			if vim.o.spell then
				vim.notify("Spell On")
			else
				vim.notify("Spell Off")
			end
		end,
		desc = "Toggle Spellcheck",
		wk_label = "Spellcheck",
	},
	{
		"<leader>tw",
		function()
			-- "<Cmd>set list! list?<CR>",
			vim.o.list = not vim.o.list
			if vim.o.list then
				vim.notify("Whitespace Characters On")
			else
				vim.notify("Whitespace Characters Off")
			end
		end,
		desc = "Toggle Whitespace Characters",
		wk_label = "Whitespace Characters",
	},
	{
		"<leader>tl",
		function()
			vim.o.wrap = not vim.o.wrap
			vim.o.linebreak = vim.o.wrap
			if vim.o.wrap then
				vim.notify("Line Wrap On")
			else
				vim.notify("Line Wrap Off")
			end
		end,
		desc = "Toggle Line Wrap",
		wk_label = "Line Wrap",
	},

	-- F-KEYS
	-- Equivalents in kitty to e.g., `<S-F3>` is `<F15>`
	{
		"<F6>",
		function() vim.notify(string.format("Filetype: %s, Buftype: %s", vim.bo.filetype, vim.bo.buftype)) end,
		desc = "Print File- and Buffertype",
	},
	{
		"<F7>",
		function()
			vim.api.nvim_feedkeys("vgv", "v", false)
			vim.schedule(function()
				local cols = vim.fn.virtcol("'>") - vim.fn.virtcol("'<") + 1
				vim.notify(string.format("Selected: %s", cols))
			end)
		end,
		"v",
		desc = "Print Selected Cols",
	},
	{
		{ "<C-F5>", "<F29>" },
		function()
			if vim.o.cmdheight == 1 then
				vim.o.cmdheight = 0
			else
				vim.o.cmdheight = 1
			end
		end,
		"",
		desc = "Toggle Command Line Height 0|1",
	},

	-- UTILITY
	{ "<kEnter>", "<CR>", { "", "!" }, desc = "Enter" },
	{ "<leader>`R", "<Cmd>ResetTerminal<CR>", desc = "Reset Terminal" },
	{ "<C-c>", "<Esc>", desc = "Escape", "" },
	{ "gV", "`[v`]", desc = "Select Last Pasted Text" },
	-- 's/S' are Utilized for Plugins Like Surround / Hop
	{ "s", "<nop>", "v" },
	-- Preserve Selection on Increment / Decrement
	{ "<C-a>", "<C-a>gv", "v", desc = "Increment" },
	{ "<C-x>", "<C-x>gv", "v", desc = "Decrement" },
	-- Undo Break Points
	{ ",", ",<C-g>u", "i", desc = "Create Undo Breakpoint for ," },
	{ ".", ".<C-g>u", "i", desc = "Create Undo Breakpoint for ." },
	{ "!", "!<C-g>u", "i", desc = "Create Undo Breakpoint for !" },
	{ "?", "?<C-g>u", "i", desc = "Create Undo Breakpoint for ?" },
	{ "<SPACE>", "<SPACE><C-g>u", "i", desc = "Create Undo Breakpoint for <space>", wk_label = "<leader>" },

	-- SCROLLING
	-- Horizontal Scrolling
	{ "<S-Right>", "2zl", desc = "Keyboard Scroll Viewport to the Right" },
	{ "<S-Left>", "2zh", desc = "Keyboard Scroll Viewport to the Left" },
	-- S-ScrollWheel works in GUIs and some TUIs (e.g., kitty)
	{ "<S-ScrollWheelDown>", "<ScrollWheelRight>", "", desc = "Mouse Scroll Viewport to the Right" },
	{ "<S-ScrollWheelUp>", "<ScrollWheelLeft>", "", desc = "Mouse Scroll Viewport to the Left" },
	-- Increase scroll distance for <C-e> / <C-y>
	-- For most clients they get overwritten by neoscroll anyway
	{ "<C-e>", "6<C-e>", "", desc = "Scroll Down" },
	{ "<C-y>", "6<C-y>", "", desc = "Scroll Up" },
})
nx.map({
	-- Fix mouse scrolling when using scroll acceleration
	{ "<S-2-ScrollWheelDown>", "<2-ScrollWheelRight>", "" },
	{ "<S-3-ScrollWheelDown>", "<3-ScrollWheelRight>", "" },
	{ "<S-4-ScrollWheelDown>", "<4-ScrollWheelRight>", "" },
	{ "<S-2-ScrollWheelUp>", "<2-ScrollWheelLeft>", "" },
	{ "<S-3-ScrollWheelUp>", "<3-ScrollWheelLeft>", "" },
	{ "<S-4-ScrollWheelUp>", "<4-ScrollWheelLeft>", "" },
}, { desc = "Fix: Scrolling with Acceleration" })
-- <== }

-- { == Plugin Keymaps ==> ====================================================

-- Plugin related keymaps are located inside the corresponding plugins config directory
-- "lua/nxvim/plugins/<pluginname>/keymaps.lua".
-- This modular approach aims for an uncluttered keymap configuration in case of removing or changing plugins.
-- <== }
