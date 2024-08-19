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

nx.hl({ { "NoiceCmdlinePopupBorder", "NoiceCmdlineIconCmdLine" }, link = "Operator" })
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
