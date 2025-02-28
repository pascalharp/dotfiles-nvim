
local options = {
    number = true,
    mouse = 'a',
    undofile = true,
    ignorecase = true,
    smartcase = true,
    timeoutlen = 300,
    updatetime = 250,
    splitright = true,
    splitbelow = true,
    list = true,
    listchars = { tab = '>-', space = '·', trail = '·', nbsp = '␣' },
    cursorline = true,
    scrolloff = 10,
    showmode = false,
}

local M = {}

M.set = function()
    for option, value in pairs(options) do
        vim.opt[option] = value
    end
end

return M
