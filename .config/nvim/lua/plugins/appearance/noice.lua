local M = {
	repo = "folke/noice.nvim",
	deps = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
}

function M.setup()
	require("noice").setup({
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = false,
			lsp_doc_border = false,
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "written" },
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
						{ find = "%d fewer lines" },
						{ find = "%d more lines" },
						{ find = "%d lines yanked" },
						{ find = "nil" },
						{ find = "refreshing" },
						{ find = "knap" },
					},
				},
				opts = { skip = true },
			},
			{
				filter = {
					event = "lsp",
					kind = "progress",
					cond = function(messages)
						local client = vim.tbl_get(messages.opts, "progress", "client")
						return client == "lua_ls"
					end,
				},
				opts = { skip = true },
			},
		},
		cmdline = {
			view = "cmdline",
		},
	})
end

return M
