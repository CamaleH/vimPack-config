local M = {}

function M.apply(keys)
	for _, key in ipairs(keys) do
		local lhs = key[1]
		local rhs = key[2]
		local mode = key.mode or "n"
		local opts = {
			desc = key.desc,
			silent = true,
		}

		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

return M
