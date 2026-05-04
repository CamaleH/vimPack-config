local apply_keys = require("config.plugin-keys").apply
local keymap = require("config.keymaps")["flash"]
local M = {
	repo = "folke/flash.nvim",
}

function M.setup()
	require("flash").setup({
		search = {
			multi_window = false,
			wrap = false,
		},
		modes = {
			search = {
				enabled = true,
			},
		},
		label = {
			uppercase = false,
			after = false,
			before = true,
			style = "overlay",
			reuse = "lowercase",
			rainbow = {
				enabled = true,
				shade = 1,
			},
		},
		char = {
			autohide = true,
		},
	})

	apply_keys(keymap["keys"])
end

return M
