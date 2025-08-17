local o = vim.opt
local g = vim.g

-- General
o.clipboard = "unnamedplus"
o.mouse = "a"
o.showmode = false
o.termguicolors = true
o.timeoutlen = 350
o.title = true
o.sessionoptions:append("globals")
o.laststatus = 3
-- Auxiliary files
o.undofile = true
o.backup = false
o.swapfile = false
-- Command line
o.cmdheight = 0
-- Completion menu
o.pumheight = 14
o.shortmess:append("c")
-- Characters
o.fillchars:append(
	"eob: ,vert:▏,vertright:▏,vertleft:▏,horiz:⸻, verthoriz:▏, fold: ,foldopen:,foldsep: ,foldclose:"
)
o.listchars:append("space:⋅, tab:▏░, trail:⋅, eol:↴")
-- Gutter
o.number = true
o.numberwidth = 3
o.relativenumber = true
o.signcolumn = "yes:2"
-- Search
o.hlsearch = true
o.ignorecase = true
o.smartcase = true
-- Windows
o.equalalways = false
o.splitbelow = true
o.splitright = true
-- Viewport
o.scrolloff = 7
o.sidescrolloff = 7
o.cursorline = true
o.colorcolumn = "120"
-- Text & line processing
o.list = false
o.spelllang = "en"
o.wrap = false
o.linebreak = true
o.whichwrap:append("<,>,[,],h,l")
-- Folds
o.foldlevel = 99
o.foldlevelstart = 99
o.foldcolumn = "1"
-- Indentation
o.expandtab = false
o.smartindent = true
o.shiftwidth = 0
o.tabstop = 3

---@class NxOpts
---@field float_win_border "single"|"rounded"|"double"|"none" @border style for float windows and cmp popups
---@field transparency boolean
nx.opts = {
	float_win_border = "rounded",
	transparency = true,
}

if g.neovide then
	o.linespace = 4
	o.guicursor =
		"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait600-blinkoff800-blinkon900-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
	o.winblend = 15
	o.pumblend = 15

	g.neovide_remember_window_size = false
	g.neovide_cursor_vfx_mode = "pixiedust"
	g.neovide_confirm_quit = 1
	g.neovide_transparency = 0.96
	g.neovide_floating_opacity = 0.15
	g.neovide_floating_blur = true
	g.neovide_floating_blur_amount_x = 2.0
	g.neovide_floating_blur_amount_y = 2.0
	g.neovide_cursor_unfocused_outline_width = 0.061
	g.neovide_no_idle = true
	g.neovide_scroll_animation_length = 0.20
	g.neovide_unlink_border_highlights = true
end
