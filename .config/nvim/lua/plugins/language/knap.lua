local apply_keys = require("config.plugin-keys").apply
local keymap = require("config.keymaps")["knap"]
local M = {
	repo = "frabjous/knap",
}

function M.setup()
	vim.g.knap_settings = {
		delay = 1000,
		texoutputext = "pdf",
		textopdfbufferasstdin = true,
		textopdf = 'xelatex -jobname "$(basename -s .pdf %outputfile%)" -halt-on-error',
		textopdfviewerlaunch = [[zathura --synctex-editor-command 'nvim --headless -es --cmd "lua require('"'"'knaphelper'"'"').relayjump('"'"'%servername%'"'"','"'"'%{input}'"'"',%{line},0)"' %outputfile%]],
		textopdfviewerrefresh = "none",
		textopdfforwardjump = "zathura --synctex-forward=%line%:%column%:%srcfile% %outputfile%",
	}

	apply_keys(keymap["keys"])
end

return M
