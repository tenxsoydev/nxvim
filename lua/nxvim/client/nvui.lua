vim.opt.fillchars:append("eob: ,fold: ,vert:│")

vim.cmd("NvuiOpacity 0.94")

nx.map({ "<S-lt>", "<gv", "v", desc = "Outdent" })
