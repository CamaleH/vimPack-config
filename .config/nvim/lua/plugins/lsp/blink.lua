local keymap = require("config.keymaps")["blink"]
local M = {
	repo = "saghen/blink.cmp",
}

function M.setup()
	require("blink.cmp").setup({
		keymap = keymap["super_bindings"],
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			documentation = { auto_show = false },
			ghost_text = { enabled = true },
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			per_filetype = {
				lua = { "lsp", "path", "snippets", "buffer", "lazydev" },
			},
			providers = {
				lazydev = {
					name = "lazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
				cmdline = {
					min_keyword_length = function(ctx)
						if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
							return 3
						end
						return 0
					end,
				},
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
		signature = {
			enabled = true,
			window = { show_documentation = false },
		},
		snippets = { preset = "luasnip" },
		cmdline = {
			keymap = keymap["cmdline"],
			completion = {
				menu = { auto_show = true },
			},
		},
	})
end

return M
