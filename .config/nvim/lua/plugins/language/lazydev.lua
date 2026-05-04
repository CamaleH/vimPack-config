local M = {
	repo = "folke/lazydev.nvim",
}

function M.setup()
	require("lazydev").setup({
		library = {
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	})
end

return M
