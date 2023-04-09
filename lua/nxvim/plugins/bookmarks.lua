-- https://github.com/tomasky/bookmarks.nvim

local bm = require("bookmarks")

-- { == Configuration ==> =====================================================

local config = {
	keymap = {}, -- See keymaps section below
	width = 0.618, -- Bookmarks window width:  (0, 1]
	height = 0.6, -- Bookmarks window height: (0, 1]
	preview_ratio = 0.4, -- Bookmarks preview window ratio (0, 1]
	preview_ext_enable = false, -- If true, preview buf will add file ext, preview window may be highlighed(treesitter), but may be slower.
	fix_enable = false, -- If true, when saving the current file, if the bookmark line number of the current file changes, try to fix it.
	hl_cursorline = "guibg=Gray guifg=White", -- hl bookmarsk window cursorline.
	virt_text = "", -- Show virt text at the end of bookmarked lines
	virt_pattern = { "*.go", "*.lua", "*.sh", "*.php", "*.rs" }, -- Show virt text only on matched pattern
}
-- <== }

-- { == Keymaps ==> ===========================================================

config.keymap = {
	toggle = "<leader>mm", -- Toggle bookmarks
	add = "<leader>ma", -- Add bookmarks
	jump = "<CR>", -- Jump from bookmarks
	delete = "dd", -- Delete bookmarks
	order = "<leader><leader>", -- Order bookmarks by frequency or updated_time
	delete_on_virt = "<leader>md", -- Delete bookmark at virt text line
	show_desc = "<leader>ms", -- show bookmark desc
}

nx.map({
	{ "q", "<Cmd>q!<CR>", ft = "bookmarks" },
})
-- <== }

nx.hl({
	{ "bookmarks_virt_text", fg = "#9dacb9" },
})

bm.setup(config)
