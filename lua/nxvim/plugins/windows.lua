-- windows.nvim/lua/windows at main · anuvyklack/windows.nvim

local M = {}

local windows = require("windows")

vim.o.winwidth = 11
vim.o.winminwidth = 11

-- == [ Configuration =========================================================

local config = {
	autowidth = {
		enable = false, -- Off by default. trigger with `<C-w>a` or command>.
		-- winwidth = 0.58,
		winwidth = 0.618, -- Golden Ratio.
	},
	ignore = {
		buftype = { "quickfix", "popup", "nofile" },
		filetype = {
			"alpha",
			"DiffviewFiles",
			"gundo",
			"neo-tree",
			"NvimTree",
			"sagarename",
			"sagaoutline",
			"undotree",
		},
	},
	animation = {
		enable = true,
		duration = 50,
		fps = 60,
		easing = "in_out_sine",
	},
}

if vim.g.loaded_gui then
	-- Lower fps seems smoother in e.g., neovide without multigrid.
	config.animation.fps = 30
	-- Use neovides builtin animations when multigrid is enabled.
	if vim.g.neovide and vim.g.multigrid then config.animation.enable = false end
end

local ignored_filetypes = config.ignore.filetype
for _, key in ipairs(ignored_filetypes) do
	ignored_filetypes[key] = true
end

windows.setup(config)
-- ]

-- == [ Commands ==============================================================

M.auto_maximize, M.auto_width = false, false

---Switch windows back and forth to trigger resize
local function pseudo_switch()
	vim.schedule(
		function()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>w<C-w><C-p>", true, false, true), "n", false)
		end
	)
end

local function enable_auto_maximize()
	M.auto_maximize = true
	vim.cmd("WindowsMaximize")
	-- vim.notify "Autowidth On"

	if M.auto_width then
		M.auto_width = false
		vim.cmd("WindowsDisableAutowidth")
	end
end

local function disable_auto_maximize()
	M.auto_maximize = false
	vim.cmd("WindowsEqualize")
	pseudo_switch()
	-- vim.notify "Autowidth Off"
end

local function toggle_auto_maximize()
	if ignored_filetypes[vim.bo.filetype] then return end
	if M.auto_maximize then
		disable_auto_maximize()
	else
		enable_auto_maximize()
	end
end

nx.cmd({
	{ "WindowsToggleAutoMaximize", toggle_auto_maximize },
	-- overwrite default WindowsToggleAutowidth autocommand
	{
		"WindowsToggleAutowidth",
		function()
			if not M.auto_width then
				M.auto_width = true
				vim.cmd("WindowsEnableAutowidth")
				pseudo_switch()
			-- vim.notify "Autowidth On"
			else
				M.auto_width = false
				vim.cmd("WindowsDisableAutowidth")
				-- vim.notify "Autowidth Off"
			end

			if M.auto_maximize then M.auto_maximize = false end
		end,
	},
})

-- ]

-- == [ Events ================================================================

local timer = vim.loop.new_timer()

nx.au({
	{
		"WinEnter",
		callback = function()
			if M.auto_maximize then
				vim.schedule(function()
					if vim.bo.filetype == "neo-tree" then
						vim.cmd("WindowsEqualize")
						return
					end
					if ignored_filetypes[vim.bo.filetype] then return end
					vim.cmd("WindowsMaximize")
				end)
			end
		end,
	},
	{
		"VimResized",
		callback = function()
			if M.auto_width then
				vim.cmd("WindowsDisableAutowidth")

				if timer then
					timer:stop()
					timer:start(
						250,
						0,
						vim.schedule_wrap(function()
							vim.cmd("WindowsEnableAutowidth")
							pseudo_switch()
						end)
					)
				end
			elseif M.auto_maximize then
				disable_auto_maximize()

				if timer then
					timer:stop()
					timer:start(450, 0, vim.schedule_wrap(enable_auto_maximize))
				end
			end
		end,
	},
	{
		"FocusLost",
		callback = function()
			if M.auto_width then vim.cmd("WindowsDisableAutowidth") end
		end,
	},
	{
		"FocusGained",
		callback = function()
			if M.auto_width then vim.cmd("WindowsEnableAutowidth") end
		end,
	},
}, { create_group = "WindowsCustomAutoWidth" })

-- ]

-- == [ Keymaps ================================================================

nx.map({
	{ "<A-CR>", "<Cmd>WindowsToggleAutoMaximize<CR>", desc = "Toggle Window Maximization" },
	{ "<A-kEnter>", "<Cmd>WindowsToggleAutoMaximize<CR>", desc = "Toggle Window Maximization" },
	{ "<C-w>a", "<Cmd>WindowsToggleAutowidth<CR>", desc = "Toggle Window Auto Width" },
	{
		"<C-w>=",
		function()
			M.auto_width = false
			M.auto_maximize = false
			vim.cmd("WindowsDisableAutowidth")
			vim.cmd("WindowsEqualize")
		end,
	},
})
-- ]

return M
