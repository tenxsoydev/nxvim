-- https://github.com/folke/noice.nvim

-- == [ Configuration =========================================================

require("noice").setup({
	lsp = {
		signature = {
			enabled = false,
		},
		progress = {
			enabled = false, -- using fidget instead as it feel less intrusive
		},
	},
	cmdline = {
		enabled = true,
		view = "cmdline",
	},
	messages = {
		view = "mini",
		view_error = "mini",
		view_warn = "mini",
		view_search = false,
	},
	notify = {
		enabled = false,
	},
	presets = {
		bottom_search = true,
		lsp_doc_border = {
			views = {
				hover = {
					border = {
						style = nx.opts.float_win_border,
						padding = { 0, 0 },
					},
				},
			},
		},
	},
	views = {
		mini = {
			win_options = {
				winblend = vim.o.winblend, -- mainly necessary to fix coloring issue in alacritty
			},
		},
	},
})

-- ]

-- == [ Events ================================================================

local hacks = require("noice.util.hacks")

nx.au({
	{ "WinEnter", "FocusGained" },
	callback = function(ev)
		-- if vim.bo[ev.buf].filetype ~= "neo-tree" then vim.cmd("set gcr=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20") end
		if not ev.buf then return end
		if vim.bo[ev.buf].filetype == "neo-tree" then
			hacks.hide_cursor()
		else
			-- hacks.show_cursor()
			vim.cmd("set gcr=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20")
		end
	end,
})
-- ]

-- == [ Keymaps ===============================================================

nx.map({
	{ "<C-j>", "<Tab>", "c", desc = "Next Entry" },
	{ "<C-k>", "<S-Tab>", "c", desc = "Previous Entry" },
})
-- ]

-- == [ Highlights ============================================================

nx.hl({ { "NoiceCmdlinePopupBorder", "NoiceCmdlineIconCmdLine" }, link = "Operator" })
-- ]
