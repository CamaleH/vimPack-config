local ht = require("haskell-tools")
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr, desc = "" }

opts.desc = "codeLenses"
vim.keymap.set("n", "<space>hcl", vim.lsp.codelens.run, opts)

opts.desc = "Hoogle Search"
vim.keymap.set("n", "<space>hhs", ht.hoogle.hoogle_signature, opts)

opts.desc = "Hoogle Evaluate all code snippets"
vim.keymap.set("n", "<space>hea", ht.lsp.buf_eval_all, opts)

opts.desc = "GHCi f package"
vim.keymap.set("n", "<leader>hrr", ht.repl.toggle, opts)

opts.desc = "GHCi f buffer"
vim.keymap.set("n", "<leader>hrf", function()
	ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, opts)

opts.desc = "GHCi quit"
vim.keymap.set("n", "<leader>hrq", ht.repl.quit, opts)
