local opts = {
	guifont = vim.g.osx and "Hasklug Nerd Font Mono:h16:#e-antialias:#h-none"
		or "Hasklug Nerd Font Mono:h11.25:#e-antialias:#h-none",
	-- guifont = "JetBrainsMono Nerd Font Mono:h11:#e-antialias:#h-none",
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
	neovide_scroll_animation_length = 0.20,
	neovide_unlink_border_highlights = true,
	-- neovide_scroll_animation_length = 0.35,
})

return opts
