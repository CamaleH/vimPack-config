local function gh(repo)
	return "https://github.com/" .. repo
end

local function module_name(file, config_dir)
	local rel = file:sub(#config_dir + 2)
	return rel:gsub("%.lua$", ""):gsub("/", "."):gsub("^lua%.", "")
end

local errors = {}

local function add_error(context, err)
	table.insert(errors, ("%s:\n%s"):format(context, tostring(err)))
end

local function notify_errors()
	if #errors == 0 then
		return
	end

	vim.schedule(function()
		vim.notify(table.concat(errors, "\n\n"), vim.log.levels.ERROR, {
			title = "vimPack plugin errors",
		})
	end)
end

local function load_plugins()
	local config_dir = vim.fn.stdpath("config")
	local files = vim.fn.globpath(config_dir, "lua/plugins/**/*.lua", false, true)
	table.sort(files)

	local plugins = {}
	for _, file in ipairs(files) do
		local module = module_name(file, config_dir)
		local ok, plugin = pcall(require, module)
		if not ok then
			add_error(("Failed to load %s"):format(module), plugin)
		elseif type(plugin) == "table" and plugin.repo then
			plugin.module = module
			table.insert(plugins, plugin)
		end
	end

	table.sort(plugins, function(a, b)
		local a_priority = a.priority or 0
		local b_priority = b.priority or 0
		if a_priority == b_priority then
			return a.module < b.module
		end
		return a_priority > b_priority
	end)

	return plugins
end

local function add_spec(specs, seen, plugin)
	local spec
	if type(plugin) == "string" then
		spec = { src = gh(plugin) }
	else
		spec = {
			src = plugin.src or gh(plugin.repo),
			version = plugin.version,
			branch = plugin.branch,
		}
	end

	if seen[spec.src] then
		return
	end

	seen[spec.src] = true
	table.insert(specs, spec)
end

local plugins = load_plugins()
local specs = {}
local seen = {}

for _, plugin in ipairs(plugins) do
	for _, dep in ipairs(plugin.deps or {}) do
		add_spec(specs, seen, dep)
	end
	add_spec(specs, seen, plugin)
end

vim.pack.add(specs, {
	confirm = false,
	load = true,
})

for _, plugin in ipairs(plugins) do
	if type(plugin.setup) == "function" then
		local ok, err = pcall(plugin.setup)
		if not ok then
			add_error(("Failed to setup %s"):format(plugin.module or plugin.repo), err)
		end
	end
end

notify_errors()
