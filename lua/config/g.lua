local globals = {
    mapleader = ' ',
    maplocalleader = ' ',
}

local M = {}

M.set = function()
    for option, value in pairs(globals) do
        vim.g[option] = value
    end
end

return M
