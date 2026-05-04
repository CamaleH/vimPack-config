local M = {
	repo = "oribarilan/lensline.nvim",
}

function M.setup()
	require("lensline").setup({
		profiles = {
			{
				name = "none",
				providers = {},
			},
			{
				name = "dev",
				providers = {
					{ name = "diagnostics", enabled = true, min_level = "HINT" },
				},
				style = { render = "all", placement = "inline" },
			},
			{
				name = "review",
				providers = {
					{ name = "last_author", enabled = true },
					{ name = "diagnostics", enabled = true, min_level = "HINT" },
					{ name = "complexity", enabled = true },
					{ name = "function_length", enabled = true },
				},
				style = { render = "all", placement = "above" },
			},
		},
	})
end

return M
