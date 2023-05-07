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

local sep = " "
dashboard.section.buttons.val = {
	-- dashboard.button("f", icons.Files .. sep .. "Files", ":Telescope find_files<CR>"),
	dashboard.button("f", "󰈢" .. sep .. "File Browser", "<Cmd>Neotree float<CR>"),
	dashboard.button("n", "󰈔" .. sep .. " New File", "<Cmd>ene <BAR> startinsert<CR>"),
	dashboard.button("r", "" .. sep .. " Recent Files", "<Cmd>Telescope oldfiles<CR>"),
	dashboard.button("p", "󰉓" .. sep .. " Projects", "<Cmd>Telescope projects<CR>"),
	dashboard.button("s", "" .. sep .. " Sessions", "<Cmd>Telescope persisted<cr>"),
	dashboard.button("o", "" .. sep .. " Options", "<Cmd>e ~/.config/nvim/lua/nxvim/options.lua<CR>"),
	dashboard.button("q", "󰗼" .. sep .. " Quit", "<Cmd>qa<CR>"),
	-- dashboard.button("b", icons.Book .. sep .. " Bookmarks", ":Telescope bookmarks list prompt_title=Bookmarks<CR>"),
	-- dashboard.button("g", icons.List .. sep .. " Grep Files", ":Telescope live_grep <CR>"),
}

---@param kind "custom"|"fortune"
local function footer(kind)
	if kind == "custom" then
		local quotes = {
			"The version of you that ends his day in gratitude: What what he do in your situation?",
			"Pray not for a lighter burden, but for stronger shoulders.",
			"Breathe brother.",
		}
		math.randomseed(os.time())
		dashboard.section.footer.val = "\n \n \n" .. quotes[math.random(#quotes)]
		return
	end

	-- Use fortune instead of a custom quote table (requires fortune to be installed on your system).
	vim.schedule(function() -- defer load to not sacrifice startup time when a fortune is fetched.
		local handle = io.popen("fortune")
		-- local handle = io.popen "fortune -a | cowsay -f bud-frogs | lolcat "
		if handle == nil then return end
		local cookie = handle:read("*a")
		handle:close()
		dashboard.section.footer.val = "\n \n \n" .. cookie
		vim.api.nvim_feedkeys("k", "n", true)
	end)
end
footer("custom")

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
		vim.schedule(function() vim.cmd("setlocal showtabline=0 | au BufWinLeave <buffer> set showtabline=2") end)
	end,
})
-- <== }

-- { == Keymaps ==> ===========================================================

nx.map({ { "<leader>a", "<Cmd>Alpha<CR>", desc = "Alpha", silent = true } })

alpha.setup(dashboard.opts)
-- <== }
