-- https://github.com/michaelb/sniprun

require("sniprun").setup()

-- == [ Commands ==============================================================

require("sniprun.live_mode") -- add SnipLive Command
-- ]

-- == [ Keymaps ===============================================================

nx.map({
	{ "<leader>Rc", "<Cmd>SnipClose<CR>", desc = "Close SnipRun" },
	{ "<leader>Rf", "<Cmd>%SnipRun<CR>", desc = "Run File" },
	{ "<leader>Ri", "<Cmd>SnipInfo<CR>", desc = "SnipRun Info" },
	{ "<leader>Rm", "<Cmd>SnipReplMemoryClean<CR>", desc = "SnipRun Clean Memory" },
	{ "<leader>Rr", "<Cmd>SnipReset<CR>", desc = "Reset SnipRun" },
	{ "<leader>Rx", "<Cmd>SnipTerminate<CR>", desc = "Terminate SnipRun" },
	{ "<leader>RR", "<Esc><Cmd>'<,'>SnipRun<CR>", "v", desc = "SnipRun Range" },
}, { wk_label = { sub_desc = "SnipRun" } })
-- ]
