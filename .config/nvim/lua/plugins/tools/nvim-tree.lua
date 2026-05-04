local keymap = require("config.keymaps")["nvim-tree"]
local apply_keys = require("config.plugin-keys").apply
local M = {
	repo = "nvim-tree/nvim-tree.lua",
	deps = { "nvim-tree/nvim-web-devicons" },
}

function M.setup()
	require("nvim-tree").setup({
		sort_by = "case_sensitive",
		view = {
			width = 30,
		},
		renderer = {
			group_empty = true,
		},
		filters = {
			dotfiles = true,
		},
		on_attach = keymap["on_attach"],
	})

	vim.api.nvim_create_autocmd("QuitPre", {
		once = true,
		callback = function()
			pcall(require("nvim-tree.api").tree.close_in_all_tabs)
		end,
	})

	apply_keys(keymap["keys"])
end

return M
