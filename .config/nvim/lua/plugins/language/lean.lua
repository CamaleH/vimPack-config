local M = {
	repo = "Julian/lean.nvim",
	deps = { "nvim-lua/plenary.nvim" },
}

function M.setup()
	require("lean").setup({
		mappings = true,
	})
end

return M
