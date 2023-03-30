-- https://github.com/folke/noice.nvim

local noice = require("noice")

-- { == Configuration ==> =====================================================

local config = {
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
		view_search = false,
	},
	notify = {
		enabled = false,
	},
	presets = {
		bottom_search = true,
		lsp_doc_border = true,
	},
	views = {
		mini = {
			win_options = {
				winblend = vim.o.winblend, -- mainly necessary to fix coloring issue in alacritty
			},
		},
	},
}

if vim.api.nvim_list_uis()[1].ext_multigrid then
	config.cmdline.enabled = false
	config.view.confirm = "mini"
end
noice.setup(config)

-- <== }

-- { == Highlights ==> ========================================================

nx.hl({ { "NoiceCmdlinePopupBorder", "NoiceCmdlineIconCmdLine" }, link = "Operator" })
-- <== }

-- { == Keymaps ==> ===========================================================

nx.map({
	{ "<C-j>", "<Tab>", "c", desc = "Next Entry" },
	{ "<C-k>", "<S-Tab>", "c", desc = "Previous Entry" },
})
-- <== }
