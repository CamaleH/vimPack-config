local keymap = require("config.keymaps")["conform"]
local apply_keys = require("config.plugin-keys").apply
local M = {
	repo = "stevearc/conform.nvim",
}

function M.setup()
	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			java = { "astyle" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			rust = { "rustfmt" },
			json = { "deno_fmt" },
		},
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
		},
	})

	apply_keys(keymap["keys"])
end

return M
