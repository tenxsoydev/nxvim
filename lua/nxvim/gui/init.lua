local o = vim.opt

o.linespace = 4
o.guicursor =
	"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait600-blinkoff800-blinkon900-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
o.winblend = 15
o.pumblend = 15

require("nxvim.plugins.size-matters")

for _, client in pairs({ "neovide" }) do
	require("nxvim.gui." .. client)
end
