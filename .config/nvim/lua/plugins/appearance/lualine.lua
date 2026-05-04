local M = {
	repo = "nvim-lualine/lualine.nvim",
	deps = { "nvim-tree/nvim-web-devicons" },
}

function M.setup()
	require("lualine").setup({
		options = {
			theme = "sonokai",
		},
	})
end

return M
