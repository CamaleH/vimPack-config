local keymap = require("config.keymaps")["fzf-lua"]
local apply_keys = require("config.plugin-keys").apply
local M = {
	repo = "ibhagwan/fzf-lua",
	deps = { "nvim-tree/nvim-web-devicons" },
}

function M.setup()
	require("fzf-lua").setup({
		winopts = {
			on_create = keymap["on_create"],
			on_close = keymap["on_close"],
		},
	})

	apply_keys(keymap["keys"])
end

return M
