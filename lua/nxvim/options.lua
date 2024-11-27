local o = vim.opt

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
o.fillchars:append("eob: ,vert:▏,vertright:▏,vertleft:▏,horiz:┈, fold: ,foldopen:,foldsep: ,foldclose:")
o.listchars:append("space:⋅, tab: ░, trail:⋅, eol:↴")
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

-- Load client-specific opts and overwrites
require("nxvim.client").load_opts()
