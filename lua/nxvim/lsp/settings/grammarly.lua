return {
	--[[ E.g.: grammarly.sh
#!/usr/bin/env bash
source "${NVM_DIR}/nvm.sh"
nvm run 16 ~/.local/share/nvim/mason/bin/grammarly-languageserver --stdio
]]
	cmd = { "/home/t/grammarly.sh" },
}
