local M = {
	repo = "windwp/nvim-autopairs",
}

function M.setup()
	require("nvim-autopairs").setup({
		ignore_next_char = "[%w%.]",
	})
end

return M
