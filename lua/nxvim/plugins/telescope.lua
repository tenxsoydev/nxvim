-- https://github.com/nvim-telescope/telescope.nvim

local telescope = require("telescope")
local lga_actions = require("telescope-live-grep-args.actions")

-- == [ Configuration =========================================================

local border = nx.opts.float_win_border ~= "none" and true or false
local borderchars = nx.opts.float_win_border == "single" and { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
	or nx.opts.float_win_border == "double" and { "═", "║", "═", "║", "╔", "╗", "╝", "╚" }
	or nil

local config = {
	defaults = {
		border = border,
		borderchars = borderchars,
		prompt_prefix = " ",
		selection_caret = "  ",
		color_devicons = true,
		path_display = { "truncate" },
		dynamic_preview_title = true,
		sorting_strategy = "descending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				preview_width = 0.58,
				-- prompt_position = "top",
				-- anchor = "N",
			},
			--[[ center = {
				anchor = "N",
			},
			vertical = {
				prompt_position = "top",
			}, ]]
		},
		mappings = {}, -- See keymaps section below
		winblend = vim.o.winblend,
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = true,
			override_file_sorter = true,
		},
		live_grep_args = {
			auto_quoting = true,
			mappings = {},
			theme = "ivy",
			border = border,
		},
		media_files = {
			filetypes = { "png", "webp", "jpg", "jpeg" },
			find_cmd = "fd",
		},
		frecency = {
			-- auto_validate = false,
			matcher = "fuzzy",
		},
	},
}

-- ]

-- == [ Keymaps ===============================================================

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

config.defaults.mappings = {
	i = {
		["<C-c>"] = actions.close,

		["<CR>"] = actions.select_default,
		["<kEnter>"] = actions.select_default,
		["<C-s>"] = actions.select_horizontal,
		["<C-v>"] = actions.select_vertical,
		["<C-t>"] = actions.select_tab,

		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
		["<C-n>"] = actions.cycle_history_next,
		["<C-p>"] = actions.cycle_history_prev,

		["<C-y>"] = actions.results_scrolling_up,
		["<C-e>"] = actions.results_scrolling_down,
		["<C-u>"] = actions.preview_scrolling_up,
		["<C-d>"] = actions.preview_scrolling_down,

		-- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
		-- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
		["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
		["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
		["<C-l>"] = actions.complete_tag,
		["<C-_>"] = actions.which_key, -- keys from pressing <C-/>

		["<Del>"] = require("telescope.actions").delete_buffer,
	},

	n = {
		["<Esc>"] = actions.close,
		["<C-c>"] = actions.close,

		["<kEnter>"] = actions.select_default,
		["<CR>"] = actions.select_default,
		["<C-x>"] = actions.select_horizontal,
		["<C-v>"] = actions.select_vertical,
		["<C-t>"] = actions.select_tab,

		["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
		["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
		["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
		["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

		["j"] = actions.move_selection_next,
		["k"] = actions.move_selection_previous,
		["H"] = actions.move_to_top,
		["M"] = actions.move_to_middle,
		["L"] = actions.move_to_bottom,

		["<Down>"] = actions.move_selection_next,
		["<Up>"] = actions.move_selection_previous,
		["gg"] = actions.move_to_top,
		["G"] = actions.move_to_bottom,

		["<C-y>"] = actions.results_scrolling_up,
		["<C-e>"] = actions.results_scrolling_down,
		["<C-u>"] = actions.preview_scrolling_up,
		["<C-d>"] = actions.preview_scrolling_down,

		["?"] = actions.which_key,
		["<Del>"] = require("telescope.actions").delete_buffer,
	},
}

config.extensions.live_grep_args.mappings = {
	i = {
		["<C-S-'>"] = lga_actions.quote_prompt(),
		['<C-">'] = lga_actions.quote_prompt(),
		-- ["<C-i>"] = lga_actions.quote_prompt { postfix = " --iglob " },
	},
}

---Search NXVim config files
---@param prompt_title string
---@param search_dirs table?
---@param search_file string?
local function find_config(prompt_title, search_dirs, search_file)
	builtin.find_files({
		cwd = vim.fn.stdpath("config") .. "/lua/nxvim",
		search_dirs = search_dirs,
		search_file = search_file,
		prompt_title = "NXVim " .. prompt_title,
	})
end

local dropdown = require("telescope.themes").get_dropdown({
	previewer = false,
	border = border,
	borderchars = borderchars,
})

nx.map({
	-- Quick Pickers
	{ "<C-p>", function() builtin.find_files(dropdown) end, desc = "Go to File" },
	{ "<A-p>", function() builtin.buffers(dropdown) end, desc = "Go to Open Buffer" },
	-- Registers
	--[[
	-- Telescopes as File Browser instead of tree plugins?
	-- shortcuts help: ':h telescope-file-browser.picker.file_browser()'
	{"<leader>te", "<Cmd>Telescope file_browser theme=ivy<CR>",  desc = "File Browser" },
	{"<leader>fe", "<Cmd>Telescope file_browser theme=ivy<CR>",  desc = "File Browser" )},
	]]
	-- Files
	{ "<leader>f/", "<Cmd>Telescope find_files<CR>", desc = "Search Files" },
	{ "<leader>fr", "<Cmd>Telescope frecency<CR>", desc = "Frecent Files" },
	{ "<leader>fR", "<Cmd>Telescope oldfiles<CR>", desc = "Recent Files" },
	-- Git
	{ "<leader>gb", "<Cmd>Telescope git_branches<CR>", desc = "Branches" },
	{ "<leader>gc", "<Cmd>Telescope git_commits<CR>", desc = "Commits" },
	{ "<leader>gf", "<Cmd>Telescope git_status<CR>", desc = "Changed Files" },
	-- History
	{ "<leader>hq", "<Cmd>Telescope quickfixhistory<CR>", desc = "Quickfixes" },
	{ "<leader>h:", "<Cmd>Telescope command_history<CR>", desc = "Commands" },
	{ "<leader>h/", "<Cmd>Telescope search_history<CR>", desc = "Searches" },
	-- LSP
	{ "<leader>ls", "<Cmd>Telescope lsp_document_symbols<CR>", desc = "Document Symbols" },
	{ "<leader>lS", "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Workspace Symbols" },
	-- Config
	-- { "<leader>,/", "<Cmd>Telescope file_browser depth=false path=~/.config/nvim grouped=true prompt_title=NXVim\\ Config<CR>", desc = "Search Config Files" }
	-- { "<leader>,k", function() find_config("Keymaps", nil, "keymaps") end, desc = "Search Keymap Files" },
	{
		"<leader>,k",
		"<Cmd>Telescope grep_string cwd=~/.config/nvim/lua/nxvim/ search=nx.map prompt_title=NXVim\\ Keymaps<CR>",
		desc = "Search Key Mappings",
	},
	-- { "<leader>,a", function() find_config("Autocmds", nil, "autocmds") end, desc = "Search Autocmd Files" },
	-- { "<leader>,g", function() find_config("GUI Options", { "client" }) end, desc = "Search GUI Client Files" },
	{ "<leader>,l", function() find_config("LSP", { "lsp" }) end, desc = "Search LSP Files" },
	{ "<leader>,p", function() find_config("Plugins", { "plugins", "lsp/plugins" }) end, desc = "Search Plugin Files" },
	{ "<leader>,c", function() find_config("Colorschemes", { "colorschemes" }) end, desc = "Search Colorscheme Files" },
	{ "<leader>,C", "<Cmd>Telescope colorscheme<CR>", desc = "Select Colorscheme", wk_label = "Colorscheme" },
})
-- Search
nx.map({
	{ "<leader>//", "<Cmd>Telescope resume<CR>", desc = "Last Search" },
	{ '<leader>/"', "<Cmd>Telescope registers<CR>", desc = "Search Registers" },
	{ "<leader>/:", "<Cmd>Telescope commands<CR>", desc = "Search Commands" },
	{ "<leader>/f", "<Cmd>Telescope find_files<CR>", desc = "Search Files" },
	-- { "<leader>/g", "<Cmd>Telescope live_grep theme=ivy<CR>",  desc = "Grep" },
	{ "<leader>/g", "<Cmd>Telescope live_grep_args<CR>", desc = "Live Grep" },
	-- As we just want to initate the grep_string command we use `:`. <Cmd> must end with `<CR>`.
	{ "<leader>/G", ":Telescope grep_string theme=ivy search=", desc = "Grep String" },
	{ "<leader>/h", "<Cmd>Telescope highlights<CR>", desc = "Search Highlights" },
	{ "<leader>/H", "<Cmd>Telescope help_tags<CR>", desc = "Search Help" },
	{ "<leader>/i", "<Cmd>Telescope media_files<CR>", desc = "Search Media" },
	{ "<leader>/k", "<Cmd>Telescope keymaps<CR>", desc = "Search Keymaps" },
	{ "<leader>/M", "<Cmd>Telescope man_pages<CR>", desc = "Search Man Pages" },
	{ "<leader>/r", telescope.extensions.recent_files.pick, desc = "Search Recent Files" },
}, { wk_label = { sub_desc = "Search" } })
-- ]

-- == [ Highlights ============================================================

nx.hl({ "TelescopeBorder", link = "LspFloatWinBorder" })
-- ]

-- == [ Load Setup ===========================================================-

telescope.setup(config)
-- ]

-- == [ Extensions ============================================================

---@param extensions string[]
local function load_extensions(extensions)
	for _, extension in ipairs(extensions) do
		telescope.load_extension(extension)
	end
end

-- Lazy load majority of extensions
vim.schedule(
	function()
		load_extensions({
			"recent_files",
			"frecency",
			"fzy_native",
			"media_files",
			"projects",
		})
	end
)
nx.au({ "TermEnter", once = true, callback = function() telescope.load_extension("termfinder") end })
-- ]
