-- https://github.com/hrsh7th/nvim-cmp

local cmp = require("cmp")

-- == [ Configuration ========================================================

local cmp_kinds = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

local config = {
	snippet = {
		expand = function(args) require("luasnip").lsp_expand(args.body) end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "nerdfont" },
		{ name = "emoji" },
		{ name = "cmp_tabnine" },
		-- { name = "copilot" },
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, item)
			if entry.source.name == "cmp_tabnine" then item.kind = "Tabnine" end
			item.menu = item.kind

			local icon = cmp_kinds[item.kind]
			if entry.source.name == "cmp_tabnine" then icon = "⌬" end -- "󰛡"
			if entry.source.name == "copilot" then icon = "" end
			item.kind = icon

			return item
		end,
	},
	window = {
		completion = {
			border = nx.opts.float_win_border,
			scrollbar = "║",
			winhighlight = "Normal:Normal", -- transparent bg
		},
		documentation = {
			border = nx.opts.float_win_border,
			scrollbar = "║",
			winhighlight = "Normal:Normal",
		},
	},
	mapping = {},
}
-- ]

-- == [ Keymaps ==============================================================

config.mapping = {
	-- Navigation completion suggestion
	-- ["<C-n>"] = cmp.mapping.select_next_item(), -- use for snippet navigation
	-- ["<C-p>"] = cmp.mapping.select_prev_item(), -- use for snippet navigation
	["<C-j>"] = cmp.mapping.select_next_item(),
	["<C-k>"] = cmp.mapping.select_prev_item(),
	["<Down>"] = cmp.mapping.select_next_item(),
	["<Up>"] = cmp.mapping.select_prev_item(),

	-- Misc
	["<C-d>"] = cmp.mapping.scroll_docs(-4),
	["<C-f>"] = cmp.mapping.scroll_docs(4),
	["<C-e>"] = cmp.mapping.close(),

	-- Invoke completion manually
	["<C-Space>"] = cmp.mapping.complete(),

	-- Confrim completion
	["<C-l>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
	["<CR>"] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Insert }),
	-- Use tab for Codeium, fall back to cmp when it's inactive
	["<Tab>"] = cmp.mapping(function(fallback)
		if not vim.g.codeium_enabled and cmp.visible() then
			cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert })
		else
			fallback()
		end
	end),
}
-- ]

require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup(config)
