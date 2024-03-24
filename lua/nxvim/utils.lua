local M = {}

---@param hl_group string|number
---@param val string|"bg"|"fg"
function M.get_hl(hl_group, val)
	local api_get_hl = vim.api.nvim_get_hl_by_name

	if type(hl_group) == "number" then api_get_hl = vim.api.nvim_get_hl_by_id end

	if val == "fg" then
		val = "foreground"
	elseif val == "bg" then
		val = "background"
	end

	local ok, hl = pcall(api_get_hl, hl_group, true)
	if not ok then return nil end

	return hl[val]
end

---@param input_path string
function M.truc_path(input_path)
	local home_path = vim.fn.expand("$HOME")
	if string.match(input_path, home_path) then input_path = input_path:gsub(home_path, "~") end

	local cfg = {
		max_dirs = 3,
		max_path_len = 2,
		prefix = "…", -- "󰘍" ""
		trunc_symbol = "…",
	}

	local path = vim.split(input_path, "/")
	local res = path[1]

	for i, _ in ipairs(path) do
		if i + 1 <= cfg.max_dirs and i + 1 < #path then
			res = res .. "/" .. ((string.sub(path[i + 1], 1, cfg.max_path_len) .. cfg.trunc_symbol) or path[i + 1])
		end
	end

	res = res .. "/" .. path[#path]

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
