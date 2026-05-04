local M = {
	repo = "lukas-reineke/indent-blankline.nvim",
}

function M.setup()
	require("ibl").setup({
		scope = {
			show_start = false,
			show_end = false,
		},
		exclude = {
			filetypes = { "help", "dashboard", "Trouble", "lazy", "neo-tree" },
		},
		whitespace = {
			remove_blankline_trail = true,
		},
	})
end

return M
