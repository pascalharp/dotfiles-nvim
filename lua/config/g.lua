local globals = {
    mapleader = ' ',
    maplocalleader = ' ',
}

local M = {}

M.setup = function()
    for option, value in pairs(globals) do
        vim.g[option] = value
    end
end

return M
