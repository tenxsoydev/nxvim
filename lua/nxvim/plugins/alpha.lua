-- https://github.com/goolord/alpha-nvim

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- { == Configuration ==> =====================================================

if vim.g.gnvim then
	dashboard.section.header.val = {
		[[        		           ]],
		[[                        ]],
		[[    Ｎ Ｘ Ｖ ｉ ｍ    ]],
		[[                        ]],
	}
else
	dashboard.section.header.val = {
		[[                    ]],
		[[                    ]],
		[[   🇳 🇽 🇻 🇮 🇲   ]],
		[[                    ]],
	}
end

local icons = require("nxvim.icons").nerd_solid
local sep = " "
dashboard.section.buttons.val = {
	-- dashboard.button("f", icons.Files .. sep .. "Files", ":Telescope find_files<CR>"),
	dashboard.button("f", icons.Files .. sep .. "File Browser", "<Cmd>Neotree float<CR>"),
	dashboard.button("n", icons.FileBlank .. sep .. " New File", "<Cmd>ene <BAR> startinsert<CR>"),
	dashboard.button("r", icons.History .. sep .. " Recent Files", "<Cmd>Telescope oldfiles<CR>"),
	dashboard.button("p", icons.Folders .. sep .. " Projects", "<Cmd>Telescope projects<CR>"),
	dashboard.button("s", icons.Interface .. sep .. " Sessions", "<Cmd>SessionManager load_session<cr>"),
	dashboard.button("o", icons.Gear .. sep .. " Options", "<Cmd>e ~/.config/nvim/lua/nxvim/options.lua<CR>"),
	dashboard.button("q", icons.CircleStop .. sep .. " Quit", "<Cmd>qa<CR>"),
	-- dashboard.button("b", icons.Book .. sep .. " Bookmarks", ":Telescope bookmarks list prompt_title=Bookmarks<CR>"),
	-- dashboard.button("g", icons.List .. sep .. " Grep Files", ":Telescope live_grep <CR>"),
}

local function footer()
	local quotes = {
		"The version of you that ends his day in gratitude: What what he do in your situation?",
		"Pray not for a lighter burden, but for stronger shoulders.",
		"Breathe brother.",
	}
	math.randomseed(os.time())
	return "\n \n \n" .. quotes[math.random(#quotes)]
end

--[[ --NOTE: if you want to use fortune instead of a custom quote table (requires fortune to be installed on your system)
-- defer load to not sacrifice startup time when a fortune is fetched.
vim.schedule(function()
	local function fortune()
		local handle = io.popen "fortune"
		-- local handle = io.popen "fortune -a | cowsay -f bud-frogs | lolcat "
		if handle == nil then return end
		local cookie = handle:read "*a"
		handle:close()
		return "\n \n \n" .. cookie
	end
	dashboard.section.footer.val = fortune()
end) ]]

-- if using fortune comment out the following line loading the footer
dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Normal"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"
dashboard.opts.opts.noautocmd = true
-- <== }

-- { == Events ==> ============================================================

nx.au({
	"User",
	pattern = "AlphaReady",
	callback = function()
		require("nxvim.plugins.telescope")
		vim.cmd("setlocal showtabline=0 | au BufWinLeave <buffer> set showtabline=2")
	end,
})
-- <== }

-- { == Keymaps ==> ===========================================================

nx.map({ { "<leader>a", "<Cmd>Alpha<CR>", desc = "Alpha", silent = true } })

alpha.setup(dashboard.opts)
-- <== }
