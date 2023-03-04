-- https://github.com/Exafunction/codeium.vim

-- { == Events ==> ============================================================

nx.au({ "FileType", pattern = "TelescopePrompt", callback = function() vim.cmd("Codeium DisableBuffer") end })
-- <== }

--- { == Keymaps ==> ===========================================================

nx.hl({ "CodeiumSuggestion", link = "SpecialComment" })
--- <== }
