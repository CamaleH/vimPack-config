local apply_keys = require("config.plugin-keys").apply
local keymap = require("config.keymaps")["outline"]
local M = {
	repo = "hedyhli/outline.nvim",
}

function M.setup()
	require("outline").setup({
		keymaps = keymap["opts-keymaps"],
	})

	apply_keys(keymap["keys"])
end

return M
