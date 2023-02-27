-- https://github.com/gelguy/wilder.nvim

local wilder = require("wilder")

-- { == Configuration ==> =====================================================

local fd_bin = "fd"
if vim.fn.executable("fdfind") == 1 then fd_bin = "fdfind" end

wilder.set_option("pipeline", {
	wilder.branch(
		wilder.python_file_finder_pipeline({
			file_command = function(ctx, arg)
				if string.find(arg, ".") ~= nil then
					return { fd_bin, "-tf", "-H" }
				else
					return { fd_bin, "-tf" }
				end
			end,
			dir_command = { fd_bin, "-td" },
			-- filters = {'cpsm_filter'},
		}),
		wilder.substitute_pipeline({
			pipeline = wilder.python_search_pipeline({
				skip_cmdtype_check = 1,
				pattern = wilder.python_fuzzy_pattern({
					start_at_boundary = 0,
				}),
			}),
		}),
		wilder.cmdline_pipeline({
			fuzzy = 2,
			fuzzy_filter = wilder.lua_fzy_filter(),
		}),
		{
			wilder.check(function(ctx, x) return x == "" end),
			wilder.history(),
		},
		wilder.python_search_pipeline({
			-- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
			pattern = wilder.python_fuzzy_pattern(),
			-- omit to get results in the order they appear in the buffer
			sorter = wilder.python_difflib_sorter(),
			-- can be set to 're2' for performance, requires pyre2 to be installed
			-- see :h wilder#python_search() for more details
			engine = "re",
		})
	),
})

local hls = {
	highlighter = wilder.lua_fzy_highlighter(), -- requires fzy-lua-native vim plugin found
	highlights = {
		accent = "SpecialChar",
		border = "FloatBorder",
	},
}

-- Improved "Classical" (Bottom) Command Menu
--[[ local popupmenu_renderer_bottom = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
	pumblend = 20,
	border = "rounded",
	empty_message = wilder.popupmenu_empty_message_with_spinner(),
	left = {
		" ",
		wilder.popupmenu_devicons(),
		wilder.popupmenu_buffer_flags({
			flags = " a + ",
			icons = { ["+"] = "", a = "", h = "" },
		}),
	},
	right = {
		" ",
		wilder.popupmenu_scrollbar(),
	},
	highlighter = hls.highlighter,
	highlights = hls.highlights,
})) ]]

-- Command Pallet (Experimental)
local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
	border = "rounded",
	min_height = 0,
	max_height = 16,
	max_width = 80,
	reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
	prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
	left = { " ", wilder.popupmenu_devicons() },
	right = {
		" ",
		wilder.popupmenu_scrollbar({
			-- thumb_char = "█",
			scrollbar_char = "║",
			scrollbar_hl = "LspFloatWinBorder",
			thumb_hl = "LspFloatWinBorder",
		}),
	},
	highlighter = hls.highlighter,
	highlights = hls.highlights,
}))

local wildmenu_renderer = wilder.wildmenu_renderer({
	separator = " · ",
	left = { " ", wilder.wildmenu_spinner(), " " },
	right = { " ", wilder.wildmenu_index() },
	highlighter = hls.highlighter,
	highlights = hls.highlights,
})

---@param state "on"|"off"
local function set_renderer(state)
	if state == "off" then
		vim.o.wildmenu = true
		wilder.set_option("renderer", wilder.renderer_mux({}))
		nx.map({
			{ "<C-j>", "<Tab>", "c" },
			{ "<C-k>", "<C-p>", "c" },
		})
		return
	end
	-- Not needed, since we use wilders internal menu. It also seems to interfere with some wilder configurations
	vim.o.wildmenu = false
	wilder.set_option(
		"renderer",
		wilder.renderer_mux({
			[":"] = popupmenu_renderer,
			["/"] = wildmenu_renderer,
			substitute = wildmenu_renderer,
		})
	)
	nx.map({
		{ "<C-j>", "<Cmd>call wilder#next()<CR>", "c" },
		{ "<C-k>", "<Cmd>call wilder#previous()<CR>", "c" },
	})
end
set_renderer("on")

-- Fix triggering search / command palette in floating window when using wilder in conjunction with noice
wilder.set_option("pre_hook", function()
	if vim.fn.win_gettype(0) == "popup" and not vim.g.zen_mode then set_renderer("off") end
end)

wilder.set_option("post_hook", function()
	if vim.fn.win_gettype(0) == "popup" and not vim.g.zen_mode then set_renderer("on") end
end)
-- <== }

-- { == Keymaps ==> ========================================================

wilder.setup({
	modes = { ":", "/", "?" },
	next_key = "<C-j>",
	previous_key = "<C-k>",
	accept_key = "<C-l>",
	reject_key = "<C-h>",
})
-- <== }

-- Kickstart to have command palette when entering cmd line for the first time after client load
vim.call("wilder#main#start")
