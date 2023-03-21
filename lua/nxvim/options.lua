nx.set({
	-- General
	clipboard = "unnamedplus", -- use system clipboard
	mouse = "a", -- allow mouse in all modes
	showmode = false, -- print vim mode on enter
	termguicolors = true, -- set term gui colors
	timeoutlen = 350, -- time to wait for a mapped sequence to complete
	title = true, -- show filename and path in application window title
	titlelen = 25, -- percentage of columns to use before shortening the title
	-- Auxiliary files
	undofile = true, -- enable persistent undo
	backup = false, -- create a backup file
	swapfile = false, -- create a swap file
	-- Command line
	cmdheight = 0,
	-- Completion menu
	pumheight = 14, -- completion popup menu height
	shortmess__append = "c", -- don't give completion-menu messages
	-- Characters
	fillchars__append = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:›,vert:▏]],
	listchars__append = [[space:⋅, tab: ░, trail:⋅, eol:↴]],
	-- Gutter
	number = true, -- show line numbers
	numberwidth = 3, -- number column width - default "4"
	relativenumber = true, -- set relative line numbers
	signcolumn = "yes:2", -- use fixed width signcolumn - prevents text shift when adding signs
	-- Search
	hlsearch = true, -- highlight matches in previous search pattern
	ignorecase = true, -- ignore case in search patterns
	smartcase = true, -- use smart case
	-- Windows
	equalalways = false, -- force equal window size on split
	splitbelow = true, -- force horizontal splits below
	splitright = true, -- force vertical splits right
	-- Viewport
	scrolloff = 7, -- number of lines to keep above / below cursor
	sidescrolloff = 7, -- number of columns to keep left / right to cursor
	cursorline = true, -- highlight the current line
	colorcolumn = "120", -- column width indicator - default "80"
	-- Text & line processing
	conceallevel = 0, -- keep backticks `` visible in markdown files
	list = false,
	spelllang = "en", -- spell checking language
	wrap = false, -- display lines as one long line
	linebreak = true, -- do not wrap lines in the middle of words
	whichwrap__append = "<,>,[,],h,l", -- move to previous / next line when reaching first / last character of line
	-- Folds
	foldlevel = 99,
	foldlevelstart = 99,
	foldcolumn = "1",
	-- Indentation
	expandtab = false, -- do not convert tabs to spaces
	smartindent = true, -- smart auto indenting when starting a new line
	shiftwidth = 0, -- number of spaces to use for (auto) indentation - zero = use tabstop value
	tabstop = 3, -- number of spaces a tab counts for
}, vim.opt)

-- Load client-specific opts after global opts
require("nxvim.client").load_opts()

-- Stash
-- winblend = 8,
-- pumblend = 8,
-- completeopt = { "menuone", "noselect", "menu" }, -- mostly for cmp
-- mousemoveevent = true,
-- softtabstop = 3,
-- updatetime = 500,
-- winfixwidth = true, -- preserve window width when windows are opened or closed
-- winfixheight = true, -- preserve window height when windows are opened or closed
-- writebackup = false, -- write backup prior to overwriting a filed changed in another instance
-- laststatus = 3, -- global statusline
-- with a global statusline some fillchars might be off when using thinner vertical this tries to give a decent result
-- fillchars__append = [[eob: ,vert:▏,vertright:▏,vertleft:▏,horiz:┈]],
