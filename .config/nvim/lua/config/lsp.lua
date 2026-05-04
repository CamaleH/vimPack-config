local keymap = require("config.keymaps")["lsp"]

keymap["global"]()

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		keymap["attach"](ev)

		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client == nil then
			return
		end

		if client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
		end
	end,
})

for _, server in ipairs({
	"lua_ls",
	"clangd",
	"pyright",
	"ts_ls",
	"texlab",
	"rust_analyzer",
}) do
	vim.lsp.enable(server)
end
