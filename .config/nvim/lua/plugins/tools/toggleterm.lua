local keymap = require("config.keymaps")["toggleterm"]
local apply_keys = require("config.plugin-keys").apply
local M = {
	repo = "akinsho/toggleterm.nvim",
}

function M.setup()
	require("toggleterm").setup({
		start_in_insert = false,
		insert_mappings = false,
	})

	apply_keys(keymap["keys"])
end

return M
