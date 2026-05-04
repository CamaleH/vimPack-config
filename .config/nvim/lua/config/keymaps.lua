local M = {
	-- fzf-lua is trigged by "<Leader>p".
	["fzf-lua"] = {
		["keys"] = {
			{ "<Leader>pp", "<cmd>FzfLua grep<CR>", mode = "n", desc = "fzf_grep" },
			{ "<Leader>pb", "<cmd>FzfLua grep_curbuf<CR>", mode = "n", desc = "fzf_grep_buff" },
			{ "<Leader>P", "<cmd>FzfLua files<CR>", mode = "n", desc = "fzf_files" },
			{ "<Leader>p", "<cmd>FzfLua grep_visual<CR>", mode = "v", desc = "fzf_grep" },
		},
		["on_create"] = function()
			vim.keymap.set("t", "<C-n>", "<Down>", { desc = "down", noremap = true, expr = false, silent = true })
			vim.keymap.set("t", "<C-e>", "<Up>", { desc = "up", noremap = true, expr = false, silent = true })
		end,
		["on_close"] = function()
			vim.keymap.del("t", "<C-n>")
			vim.keymap.del("t", "<C-e>")
		end,
	},
	["conform"] = {
		["keys"] = {
			{ "<leader>f", function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end, mode = "", desc = "Format buffer" },
		},
	},
	["flash"] = {
		["keys"] = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
		},
	},
	-- outline is trigged by "<Leader>o".
	["outline"] = {
		["keys"] = {
			{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		["opts-keymaps"] = {
			peek_location = "p",
			hover_symbol = "E",
			rename_symbol = "rn",
			fold = "y",
			unfold = "o",
		},
	},
	-- terminal and tree file explore are trigged by "<Leader>t".
	["toggleterm"] = {
		["keys"] = {
			{
				"<Leader>te",
				"<cmd>ToggleTerm size=10 direction=horizontal name=def<CR>",
				desc = "Toggle default terminal",
			},
		},
	},
	["nvim-tree"] = {
		["keys"] = {
			{ "<Leader>tt", "<cmd>NvimTreeFocus<CR>", mode = "n", desc = "open tree" },
			{ "<Leader>tc", "<cmd>NvimTreeClose<CR>", mode = "n", desc = "close tree" },
		},
		["on_attach"] = function(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			vim.keymap.set("n", "cd", api.tree.change_root_to_node, opts("change root"))
			vim.keymap.set("n", "cw", api.fs.rename, opts("rename"))
			vim.keymap.set("n", "ft", api.fs.create, opts("fs create"))
			vim.keymap.set("n", "kk", api.fs.copy.node, opts("copy"))
			vim.keymap.set("n", "dd", api.fs.remove, opts("fs remove"))
			vim.keymap.set("n", "ka", api.fs.copy.absolute_path, opts("copy abs path"))
			vim.keymap.set("n", "kr", api.fs.copy.relative_path, opts("copy rlt path"))
			vim.keymap.set("n", "kn", api.fs.copy.filename, opts("copy fname"))
			vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("open vertical"))
			vim.keymap.set("n", "<C-s>", api.node.open.horizontal, opts("open horizontal"))
			vim.keymap.set("n", "<CR>", api.node.open.edit, opts("open"))
			vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("preview"))
			vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("chroot p"))
			vim.keymap.set("n", "zh", api.tree.toggle_hidden_filter, opts("toggle_hide"))
		end,
	},
	["blink"] = {
		["super_bindings"] = {
			preset = "none",
			["<A-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-c>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-h>"] = { "select_prev", "fallback_to_mappings" },
			["<C-s>"] = { "select_next", "fallback_to_mappings" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-j>"] = { "scroll_documentation_down", "fallback" },
			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		},
		["cmdline"] = {
			preset = "inherit",
			["<Tab>"] = { "accept" },
			["<CR>"] = { "accept_and_enter", "fallback" },
		},
	},
	["lsp"] = {
		["global"] = function()
			vim.keymap.set("n", "<Leader>d", vim.diagnostic.open_float, { desc = "diag_open_float" })
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end, { desc = "diag_prev" })
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end, { desc = "diag_next" })
			vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist, { desc = "diag_setloclist" })
		end,
		["attach"] = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if client == nil then
				return
			end

			if client:supports_method("textDocument/codeAction") then
				vim.keymap.set({ "n", "v" }, "<Leader>la", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "code action" })
			end

			if client:supports_method("textDocument/declaration") then
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "go decl" })
			end
			if client:supports_method("textDocument/definition") then
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "go def" })
			end
			if client:supports_method("textDocument/hover") then
				vim.keymap.set("n", "E", vim.lsp.buf.hover, { buffer = ev.buf, desc = "hover" })
			end
			if client:supports_method("textDocument/implementation") then
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "go impl" })
			end
			if client:supports_method("textDocument/references") then
				vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "go refer" })
			end
			if client:supports_method("textDocument/rename") then
				vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "rename" })
			end
			if client:supports_method("textDocument/typeDefinition") then
				vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "go type def" })
			end
		end,
	},
	["opencode"] = {
		["keys"] = {
			{ "<Leader>ca", function() require("opencode").ask("@this: ", { submit = true }) end, mode = { "n", "x" }, desc = "ask opencode" },
			{ "<Leader>cs", function() require("opencode").select() end, mode = "n", desc = "select opencode action" },
			{ "<Leader>ct", function() require("opencode").toggle() end, mode = { "n", "t" }, desc = "toggle opencode" },
		},
	},
	["knap"] = {
		["keys"] = {
			{ "<Leader>lf", function() require("knap").process_once() end, mode = "n", desc = "fresh once" },
			{ "<Leader>lc", function() require("knap").close_viewer() end, mode = "n", desc = "close viewer" },
			{ "<Leader>la", function() require("knap").toggle_autopreviewing() end, mode = "n", desc = "auto fresh" },
			{ "<Leader>lj", function() require("knap").forward_jump() end, mode = "n", desc = "forward jump" },
		},
	},
}

local function map_to(mode, value, desc, expr)
	return {
		mode = mode,
		desc = desc,
		value = value,
		silent = true,
		noremap = true,
		expr = expr,
	}
end

local workman_schema = {
	y = map_to({ "n", "x", "o" }, "h", "left", false),
	n = map_to({ "n", "x", "o" }, [[v:count > 0 ? "m'" . v:count . "j" : 'gj']], "down", true),
	e = map_to({ "n", "x", "o" }, [[v:count > 0 ? "m'" . v:count . "k" : 'gk']], "up", true),
	o = map_to({ "n", "x", "o" }, "l", "right", false),
	Y = map_to({}, "^", "start of line", false),
	O = map_to({}, "$", "end of line", false),
	k = map_to({}, "y", "kopy", false),
	K = map_to({}, "Y", "kopy line", false),
	W = map_to({}, "e", "Next word end", false),
	l = map_to({}, "o", "insert line below", false),
	L = map_to({}, "O", "insert line above", false),
	h = map_to({}, "n", "find next", false),
	H = map_to({}, "N", "find prev", false),
	["<C-y>"] = map_to({}, "<C-w>h", "focus left", false),
	["<C-n>"] = map_to({}, "<C-w>j", "focus down", false),
	["<C-e>"] = map_to({}, "<C-w>k", "focus up", false),
	["<C-o>"] = map_to({}, "<C-w>l", "focus right", false),
	["<C-w>Y"] = map_to({}, "<C-w>H", "move window left", false),
	["<C-w>N"] = map_to({}, "<C-w>J", "move window down", false),
	["<C-w>E"] = map_to({}, "<C-w>K", "move window up", false),
	["<C-w>O"] = map_to({}, "<C-w>L", "move window right", false),
	["<C-,>"] = map_to({}, "<C-w><", "decrease current window width", false),
	["<C-.>"] = map_to({}, "<C-w>>", "increase current window width", false),
	["<F11>"] = map_to({}, "<C-w>-", "decrease current window height", false),
	["<F12>"] = map_to({}, "<C-w>+", "increase current window height", false),
	["("] = map_to({}, "<C-o>", "jumplist back", false),
	[")"] = map_to({}, "<C-i>", "jumplist forward", false),
}

local function apply_map_schema(schema)
	for lhs, rhs in pairs(schema) do
		if #rhs.mode == 0 then
			vim.keymap.set("", lhs, rhs.value, {
				desc = rhs.desc,
				noremap = true,
				expr = rhs.expr,
				silent = true,
			})
		else
			for _, m in ipairs(rhs.mode) do
				vim.keymap.set(m, lhs, rhs.value, {
					desc = rhs.desc,
					noremap = true,
					expr = rhs.expr,
					silent = true,
				})
			end
		end
	end
	end

for _, mode_lhs in ipairs({
	{ "n", "grn" },
	{ "n", "gra" },
	{ "n", "grr" },
	{ "n", "gri" },
	{ "n", "grt" },
	{ "n", "gO" },
	{ "i", "<C-s>" },
}) do
	pcall(vim.keymap.del, mode_lhs[1], mode_lhs[2])
end

apply_map_schema(workman_schema)

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

return M
