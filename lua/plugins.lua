local misc = require("utils/misc")

local M = {
	found = {},
	loaded = {}
}

local function eval_plug(module)
	local ok, res = pcall(require, module)
	if ok then
		table.insert(M.found, res)
	end
end

local function load_plugs()
	vim.pack.add(M.found)
	M.loaded = vim.pack.get()
end

local function setup_hook()
	if M.loaded == nil then
		return
	end
	for _, plug in ipairs(M.loaded) do
		if plug.spec.data ~= nil and plug.spec.data.setup ~= nil then
			plug.spec.data.setup()
		end
	end
end

function M:setup()
	local plugins = misc:wildcard_modules("plugins/**")

	for _, plug in ipairs(plugins) do
		eval_plug(plug)
	end

	load_plugs()
	setup_hook()
end

return M
