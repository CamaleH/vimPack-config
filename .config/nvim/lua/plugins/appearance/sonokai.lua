local M = {
	repo = "sainnhe/sonokai",
	priority = 1000,
}

function M.setup()
	vim.g.sonokai_style = "andromeda"
	vim.g.sonokai_enable_italic = true
	vim.g.sonokai_better_performance = 1
	vim.g.sonokai_dim_inactive_windows = 1

	vim.cmd.colorscheme("sonokai")
end

return M
