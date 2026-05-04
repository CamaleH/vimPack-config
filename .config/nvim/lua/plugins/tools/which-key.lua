local M = {
	repo = "folke/which-key.nvim",
}

function M.setup()
	vim.o.timeout = true
	vim.o.timeoutlen = 300

	require("which-key").setup({
		plugins = {
			presets = {},
		},
		layout = {
			height = { min = 4, max = 8 },
		},
	})
end

return M
