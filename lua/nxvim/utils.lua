local M = {}

---@param hl_group string|number
---@param val string|"bg"|"fg"
function M.get_hl(hl_group, val)
	if val == "fg" then
		val = "foreground"
	elseif val == "bg" then
		val = "background"
	end

	local ok, hl = pcall(vim.api.nvim_get_hl, hl_group, true)
	if not ok then return nil end

	return hl[val]
end

---@class TruncConfig
---@field max_dirs number
---@field trun_len number
---@field trunc_symbol string

---@type TruncConfig
local default_trunc_config = {
	max_dirs = 3,
	trun_len = 2,
	trunc_symbol = "…",
}

---@param path string
---@param config? TruncConfig
function M.trunc_path(path, config)
	-- Use `~` in case home path was passed expanded
	path = path:gsub(vim.fn.expand("~"), "~")
	config = vim.tbl_deep_extend("keep", config or {}, default_trunc_config)

	local path_segments = vim.split(path, "/")
	local res = path_segments[1]

	for i, _ in ipairs(path_segments) do
		if i + 1 <= config.max_dirs and i + 1 < #path_segments then
			res = res
				.. "/"
				.. (
					(string.sub(path_segments[i + 1], 1, config.trun_len) .. config.trunc_symbol)
					or path_segments[i + 1]
				)
		end
	end

	res = res .. "/" .. path_segments[#path_segments]

	return res
end

-- Auto window height - use for qf lists
vim.cmd([[
fun! AdjustWindowHeight(minheight, maxheight)
	exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfun
]])

nx.cmd({
	{ "ResetTerminal", function() vim.cmd("set scrollback=1 | sleep 10m | set scrollback=10000") end },
	{
		"WipeRegisters",
		function()
			for i = 34, 122 do
				pcall(vim.fn.setreg, vim.fn.nr2char(i), "")
			end
			vim.cmd("wshada!")
		end,
		desc = "Clear All Registers",
	},
})

return M
