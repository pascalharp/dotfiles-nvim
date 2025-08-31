local misc = require("utils/misc")

local M = {}

function M:setup()
	local modules = misc:wildcard_modules("config")

	-- Setting this first, to make sure all keybinds are correct
	vim.g.mapleader = ' '
	vim.g.maplocalleader = ' '

	for _, mod in ipairs(modules) do
		require(mod):setup()
	end
end

return M
