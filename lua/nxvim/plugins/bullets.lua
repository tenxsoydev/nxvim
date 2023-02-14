-- https://github.com/dkarter/bullets.vim

-- { == Configuration ==> =====================================================

nx.set({
	bullets_set_mappings = 0,
	-- bullets_custom_mappings = { { "nmap", "<leader>x", "<nop>" }, { "nmap", ">", "<nop>" } },
	-- bullets_outline_levels = { 'ROM', 'ABC', 'num', 'abc', 'rom', 'std-', 'std*', 'std+' },
	bullets_outline_levels = { "num", "abc", "std*" },
	-- bullets_checkbox_markers = " ○●✓",
	bullets_checkbox_markers = " x",
	bullets_nested_checkboxes = 0,
})
-- <== }
