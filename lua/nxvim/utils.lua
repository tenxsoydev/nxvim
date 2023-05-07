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

	local config = {
		max_dirs = 2,
		shorten = true,
		prefix = "…", -- "󰘍" ""
		trunc_symbol = "…",
	}

	local file_sep = package.config:sub(1, 1)
	local file = vim.split(input_path, file_sep)
	local path = ""

	for dirs, _ in ipairs(file) do
		if dirs <= config.max_dirs then
			if config.max_dirs ~= 1 and dirs == 1 then
				-- first level files (directly in project root)
				if file[#file - config.max_dirs] == nil then
					path = path .. file[#file - (#file - 1)]
				else
					path = path .. file[#file - config.max_dirs]
				end
			else
				-- tip for debugging: use somthing like *test* inside "/"
				if file[#file - dirs] == nil then
					path = path .. "/" .. file[#file - (#file - dirs)]
				else
					-- middle position
					path = path
						.. "/"
						.. (
							(
								config.shorten
								and string.sub(file[#file - (config.max_dirs - (dirs - 1))], 1, 2)
									.. config.trunc_symbol
							) or file[#file - (config.max_dirs - (dirs - 1))]
						)
				end
			end
		else
			-- actual filename
			if file[#file - dirs] == nil then
				path = path .. "/" .. file[#file]
				break
			else
				path = config.prefix .. path .. "/" .. file[#file]
				break
			end
		end
	end

	return path
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
