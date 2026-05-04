local M = {
	repo = "nvimdev/dashboard-nvim",
	deps = { "nvim-tree/nvim-web-devicons" },
}

function M.setup()
	require("dashboard").setup({
		theme = "hyper",
		shortcut_type = "letter",
		change_to_vcs_root = false,
		config = {
			shortcut_type = {},
			week_header = {
				enable = true,
			},
			footer = {},
		},
	})
end

return M
