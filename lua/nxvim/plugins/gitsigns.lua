-- https://github.com/lewis6991/gitsigns.nvim

local gitsigns = require("gitsigns")

-- { == Configuration ==> =====================================================

local config = {
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
}
-- <== }

-- { == Keymaps ==> ===========================================================

config.on_attach = function(bufnr)
	local gs = package.loaded.gitsigns

	-- Navigation
	nx.map({
		{
			"<leader>gj",
			function()
				if vim.wo.diff then return "]c" end
				vim.schedule(function() gs.next_hunk() end)
				return "<Ignore>"
			end,
			desc = "Next Hunk",
		},
		{
			"<leader>gk",
			function()
				if vim.wo.diff then return "[c" end
				vim.schedule(function() gs.prev_hunk() end)
				return "<Ignore>"
			end,
			desc = "Previous Hunk",
		},
	}, { expr = true })
	-- Actions
	nx.map({
		{ "<leader>gs", gs.stage_hunk, { "n", "v" }, desc = "Stage Hunk" },
		{ "<leader>gr", gs.reset_hunk, { "n", "v" }, desc = "Reset Hunk" },
		{ "<leader>gp", gs.preview_hunk, desc = "Preview Hunk" },
		{ "<leader>gu", gs.undo_stage_hunk, desc = "Undo Stage Hunk" },
		{ "<leader>gS", gs.stage_buffer, desc = "Stage Buffer" },
		{ "<leader>gR", gs.reset_buffer, desc = "Reset Buffer" },
		{ "<leader>gB", gs.blame_line, desc = "Blame Line" },
		{ "<leader>gD", function() gs.diffthis("~") end, desc = "Toggle Deleted Lines" },
		-- { "<leader>gd", gs.diffthis },
		-- { "<leader>tD", gs.toggle_deleted },
		{ "<leader>tb", gs.toggle_current_line_blame, desc = "Toggle Blame", wk_label = "Blame" }, --wk_label not working as it is a buffer local mapping
		-- Text object
		{ "ih", ":<C-U>Gitsigns select_hunk<CR>", { "o", "x" }, desc = "Select Hunk" },
	}, { buffer = bufnr })
end
-- <== }

-- { == Highlights ==> ========================================================

nx.hl({ "GitSignsCurrentLineBlame", fg = "Debug:fg", bg = "CursorLine:bg", italic = true })

-- <== }

gitsigns.setup(config)
