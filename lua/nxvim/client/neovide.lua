local opts = {
	guifont = vim.g.osx and "Hasklug Nerd Font Mono:h14:#e-subpixelantialias" or "Hasklug Nerd Font Mono:h12",
	-- guifont = "JetBrainsMono Nerd Font Mono:h14:#e-subpixelantialias",
	-- guifont = "JetBrains Mono Light, JetBrainsMono NFM:h10:#e-antialias", -- made the best experience with JetBrains fonts
	-- guifont = "VictorMono Nerd Font Mono:h13:#e-antialias", -- proper icons, f*ed up italics
	-- guifont = "VictorMono Nerd Font:h10:#e-antialias", -- proper italics, f*ed up icons
}
if vim.g.multigrid then
	opts.winblend = 15
	opts.pumblend = 15
end

nx.set({
	neovide_remember_window_size = false,
	neovide_cursor_vfx_mode = "pixiedust",
	neovide_confirm_quit = 1,
	neovide_transparency = 0.94,
	neovide_floating_opacity = 0.15,
	neovide_floating_blur = true,
	neovide_floating_blur_amount_x = 2.0,
	neovide_floating_blur_amount_y = 2.0,
	neovide_cursor_unfocused_outline_width = 0.061,
	neovide_no_idle = true,
	neovide_scroll_animation_length = 0,
	-- neovide_scroll_animation_length = 0.35,
})

return opts
