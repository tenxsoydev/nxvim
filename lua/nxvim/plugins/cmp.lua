-- https://github.com/hrsh7th/nvim-cmp

local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()

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
		{ name = "cmp_tabnine" },
		{ name = "path" },
		{ name = "nerdfont" },
		-- { name = "copilot" },
		-- { name = "emoji" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
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
	experimental = {
		ghost_text = false,
		-- native_menu = false,
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
	["<C-l>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
	["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false }),
	-- ["<Tab>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
	-- Use tab for codeium and it should fall back to cmp when it's inactive
	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() and vim.g.codeium_enabled ~= 1 then
			cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
		else
			fallback()
		end
	end, { "i", "s" }),

	-- Use tab to cycles through completion suggestions
	--[[ ["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif require("luasnip").expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif require("luasnip").jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}), ]]
}
-- ]

cmp.setup(config)
