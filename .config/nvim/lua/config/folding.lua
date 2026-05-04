local opt = vim.opt

opt.foldmethod = "indent"
opt.fillchars = [[eob: ,fold: ,foldsep: ]]
opt.foldlevel = 99

function _G.custom_foldtext()
	local start_text = vim.fn.getline(vim.v.foldstart):gsub("\t", string.rep(" ", vim.o.tabstop))
	local nline = vim.v.foldend - vim.v.foldstart
	return string.format("%s ... ↙ %d lines", start_text, nline)
end

vim.opt.foldtext = "v:lua.custom_foldtext()"
