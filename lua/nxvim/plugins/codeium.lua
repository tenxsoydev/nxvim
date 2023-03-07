-- https://github.com/Exafunction/codeium.vim

-- { == Events ==> ============================================================

nx.au({ "FileType", pattern = "TelescopePrompt", callback = function() vim.cmd("Codeium DisableBuffer") end })
-- <== }

--- { == Highlights ==> =======================================================

nx.hl({ "CodeiumSuggestion", link = "SpecialComment" })
--- <== }

--- { == Keymaps ==> ===========================================================

-- Map <Tab> manually as loading codeium "VeryLazy" won't map it automatically
nx.map({ "<Tab>", function() return vim.fn["codeium#Accept"]() end, "i", expr = true })
--- <== }

-- Explicitly call `Codeium Enable` to trigger assigning a value to `vim.g.codeium_enable`.
-- This is because Codeium does not currently set this global variable when it first activates.
vim.cmd("Codeium Enable")
