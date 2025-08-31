
local M = {}

function M:setup()
	local kb =  require("utils/keybinds")
	kb.core:set('n', '<C-h>', '<C-w>h', { desc = "Goto left window" })
	kb.core:set('n', '<C-l>', '<C-w>l', { desc = "Goto right window" })
	kb.core:set('n', '<C-j>', '<C-w>j', { desc = "Goto down window" })
	kb.core:set('n', '<C-k>', '<C-w>k', { desc = "Goto up window" })
	kb.core:set('n', '<C-Up>', '<cmd>resize +5<cr>', { desc = "Increase window height" })
	kb.core:set('n', '<C-Down>', '<cmd>resize -5<cr>', { desc = "Decrease window height" })
	kb.core:set('n', '<C-Right>', '<cmd>vertical resize +5<cr>', { desc = "Increase window width" })
	kb.core:set('n', '<C-Left>', '<cmd>vertical resize -5<cr>', { desc = "Decrease window width" })
	kb.windows:set('n', 'v', '<cmd>vsplit<cr>', { desc = "Split vertical" })
	kb.windows:set('n', 'h', '<cmd>split<cr>', { desc = "Split horizontal" })
	kb.windows:set('n', 'w', '<C-w>', { desc = "Window options", silent = false })
	kb.windows:set('n', 'q', '<C-w>q', { desc = "Close window", silent = false })
end

return M
