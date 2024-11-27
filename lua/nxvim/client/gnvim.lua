vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h12.5"

local function set_hl()
	nx.hl({
		-- { "IlluminatedWordText", sp = "LineNr:fg", underline = true },
		{ "IlluminatedWordText", bg = "Visual:bg" },
		{ "IlluminatedWordRead", link = "IlluminatedWordText" },
		{ "IlluminatedWordWrite", link = "IlluminatedWordText" },
	})
end

nx.au({ { "UIEnter", once = true, callback = set_hl } })
