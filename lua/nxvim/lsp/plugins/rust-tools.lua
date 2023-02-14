-- https://github.com/simrat39/rust-tools.nvim

local function init() require("rust-tools").setup() end

nx.au({ "Filetype", once = true, pattern = "rust", callback = init })
