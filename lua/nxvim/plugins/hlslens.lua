-- https://github.com/kevinhwang91/nvim-hlslens

-- { == Configuration ==> =====================================================

require("hlslens").setup({
	override_lens = function(render, posList, nearest, idx, relIdx)
		local sfw = vim.v.searchforward == 1
		local indicator, text, chunks
		local absRelIdx = math.abs(relIdx)
		if absRelIdx > 1 then
			indicator = ("%d%s"):format(absRelIdx, sfw ~= (relIdx > 1) and "N" or "n")
		elseif absRelIdx == 1 then
			indicator = sfw ~= (relIdx == 1) and "N" or "n"
		else
			indicator = ""
		end

		local lnum, col = unpack(posList[idx])
		if nearest then
			local cnt = #posList
			if indicator ~= "" then
				text = ("[%s %d/%d]"):format(indicator, idx, cnt)
			else
				text = ("[%d/%d]"):format(idx, cnt)
				-- if vim.g.multigrid then text = text .. " /" .. vim.fn.getreg("/") end
			end
			chunks = { { " ", "Ignore" }, { text, "HlSearchNear" } }
		else
			text = ("[%s %d]"):format(indicator, idx)
			chunks = { { " ", "Ignore" }, { text, "HlSearchLens" } }
		end
		render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
	end,
})
-- <== }

-- { == Highlights ==> ========================================================

nx.hl({ "HlSearchLens", link = "NoiceVirtualText" })
-- <== }
